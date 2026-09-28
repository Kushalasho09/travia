import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_manager.dart';
import '../base_auth_user_provider.dart';
import '../../flutter_flow/flutter_flow_util.dart';

import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_transform/stream_transform.dart';
import 'anonymous_auth.dart';
import 'apple_auth.dart';
import 'email_auth.dart';
import 'firebase_user_provider.dart';
import 'google_auth.dart';
import 'jwt_token_auth.dart';
import 'github_auth.dart';
import '../apitxt_auth/apitxt_service.dart';

export '../base_auth_user_provider.dart';

class FirebasePhoneAuthManager extends ChangeNotifier {
  bool? _triggerOnCodeSent;
  dynamic phoneAuthError;
  String? phoneNumber;
  int? resendToken;
  // Set when using phone verification (after phone number is provided).
  String? phoneAuthVerificationCode;
  // Set when using phone sign in in web mode (ignored otherwise).
  ConfirmationResult? webPhoneAuthConfirmationResult;
  // Used for handling verification codes for phone sign in.
  void Function(BuildContext)? _onCodeSent;

  bool get triggerOnCodeSent => _triggerOnCodeSent ?? false;
  set triggerOnCodeSent(bool val) => _triggerOnCodeSent = val;

  void Function(BuildContext) get onCodeSent =>
      _onCodeSent == null ? (_) {} : _onCodeSent!;
  set onCodeSent(void Function(BuildContext) func) => _onCodeSent = func;

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}

class FirebaseAuthManager extends AuthManager
    with
        EmailSignInManager,
        GoogleSignInManager,
        AppleSignInManager,
        AnonymousSignInManager,
        JwtSignInManager,
        GithubSignInManager,
        PhoneSignInManager {
  // Set when using phone verification (after phone number is provided).
  String? _phoneAuthVerificationCode;
  // Set when using phone sign in in web mode (ignored otherwise).
  ConfirmationResult? _webPhoneAuthConfirmationResult;
  FirebasePhoneAuthManager phoneAuthManager = FirebasePhoneAuthManager();

  @override
  Future signOut() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future deleteUser(BuildContext context) async {
    try {
      if (!loggedIn) {
        print('Error: delete user attempted with no logged in user!');
        return;
      }
      await currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Too long since most recent sign in. Sign in again before deleting your account.')),
        );
      }
    }
  }

  @override
  Future updateEmail({
    required String email,
    required BuildContext context,
  }) async {
    try {
      if (!loggedIn) {
        print('Error: update email attempted with no logged in user!');
        return;
      }
      await currentUser?.updateEmail(email);
      await updateUserDocument(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Too long since most recent sign in. Sign in again before updating your email.')),
        );
      }
    }
  }

  @override
  Future updatePassword({
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      if (!loggedIn) {
        print('Error: update password attempted with no logged in user!');
        return;
      }
      await currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message!}')),
        );
      }
    }
  }

  @override
  Future resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message!}')),
      );
      return null;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset email sent')),
    );
  }

  @override
  Future<BaseAuthUser?> signInWithEmail(
    BuildContext context,
    String email,
    String password,
  ) =>
      _signInOrCreateAccount(
        context,
        () => emailSignInFunc(email, password),
        'EMAIL',
      );

  @override
  Future<BaseAuthUser?> createAccountWithEmail(
    BuildContext context,
    String email,
    String password,
  ) =>
      _signInOrCreateAccount(
        context,
        () => emailCreateAccountFunc(email, password),
        'EMAIL',
      );

  @override
  Future<BaseAuthUser?> signInAnonymously(
    BuildContext context,
  ) =>
      _signInOrCreateAccount(context, anonymousSignInFunc, 'ANONYMOUS');

  @override
  Future<BaseAuthUser?> signInWithApple(BuildContext context) =>
      _signInOrCreateAccount(context, appleSignIn, 'APPLE');

  @override
  Future<BaseAuthUser?> signInWithGoogle(BuildContext context) =>
      _signInOrCreateAccount(context, googleSignInFunc, 'GOOGLE');

  @override
  Future<BaseAuthUser?> signInWithGithub(BuildContext context) =>
      _signInOrCreateAccount(context, githubSignInFunc, 'GITHUB');

  @override
  Future<BaseAuthUser?> signInWithJwtToken(
    BuildContext context,
    String jwtToken,
  ) =>
      _signInOrCreateAccount(context, () => jwtTokenSignIn(jwtToken), 'JWT');

  static String getAuthErrorMessage(FirebaseAuthException e) {
    return switch (e.code) {
      'invalid-phone-number' =>
        'The phone number entered is invalid. Please check and try again.',
      'quota-exceeded' =>
        'SMS quota exceeded. Please try again later or contact support.',
      'too-many-requests' =>
        'Too many attempts from this device. Please try again later.',
      'app-not-authorized' =>
        'App is not authorized. Please verify SHA certificate fingerprints in Firebase Console.',
      'captcha-check-failed' =>
        'Device verification failed. Please try again.',
      'invalid-verification-code' =>
        'The verification code entered is incorrect. Please try again.',
      'session-expired' =>
        'The verification code has expired. Please request a new code.',
      _ => e.message != null && e.message!.isNotEmpty
          ? 'Error: ${e.message}'
          : 'Authentication error (${e.code}).',
    };
  }

  void handlePhoneAuthStateChanges(BuildContext context) {
    phoneAuthManager.addListener(() {
      if (!context.mounted) {
        return;
      }

      if (phoneAuthManager.triggerOnCodeSent) {
        phoneAuthManager.onCodeSent(context);
        phoneAuthManager
            .update(() => phoneAuthManager.triggerOnCodeSent = false);
      } else if (phoneAuthManager.phoneAuthError != null) {
        final e = phoneAuthManager.phoneAuthError!;
        final errorMsg = e is FirebaseAuthException
            ? getAuthErrorMessage(e)
            : e.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMsg),
          backgroundColor: Colors.red.shade700,
        ));
        phoneAuthManager.update(() => phoneAuthManager.phoneAuthError = null);
      }
    });
  }

  @override
  Future beginPhoneAuth({
    required BuildContext context,
    required String phoneNumber,
    required void Function(BuildContext) onCodeSent,
  }) async {
    phoneAuthManager.update(() {
      phoneAuthManager.phoneNumber = phoneNumber;
      phoneAuthManager.onCodeSent = onCodeSent;
      phoneAuthManager.phoneAuthError = null;
    });

    final result = await ApitxtService.instance.sendOtp(phoneNumber);

    if (result['success'] == true) {
      phoneAuthManager.update(() {
        phoneAuthManager.triggerOnCodeSent = true;
        phoneAuthManager.phoneAuthError = null;
      });
      // If no listener (like handlePhoneAuthStateChanges) handled triggerOnCodeSent,
      // invoke onCodeSent directly:
      if (phoneAuthManager.triggerOnCodeSent && context.mounted) {
        phoneAuthManager.update(() => phoneAuthManager.triggerOnCodeSent = false);
        onCodeSent(context);
      }
      return true;
    } else {
      final errorMsg = result['message'] ?? 'Failed to send OTP via SMS';
      phoneAuthManager.update(() {
        phoneAuthManager.triggerOnCodeSent = false;
        phoneAuthManager.phoneAuthError = errorMsg;
      });
      return false;
    }
  }

  @override
  Future verifySmsCode({
    required BuildContext context,
    required String smsCode,
  }) async {
    // 1. Verify entered code against the code sent via APITxT
    final verifyResult = ApitxtService.instance.verifyOtp(smsCode);
    if (verifyResult['success'] != true) {
      final errorMsg = verifyResult['message'] ?? 'Invalid verification code.';
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          backgroundColor: Colors.red.shade700,
        ),
      );
      return null;
    }

    // 2. Sign in or create account in Firebase Auth to establish the user session
    final cleanPhone = ApitxtService.instance.clean10DigitPhone;
    final syntheticEmail = 'phone_$cleanPhone@travia.internal';
    final syntheticPassword = 'TraviaAuth_${cleanPhone}_#Secure2026!';
    final actualPhone = phoneAuthManager.phoneNumber ?? '+91$cleanPhone';

    final user = await _signInOrCreateAccount(
      context,
      () async {
        try {
          return await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: syntheticEmail,
            password: syntheticPassword,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found' ||
              e.code == 'INVALID_LOGIN_CREDENTIALS' ||
              e.code == 'invalid-credential') {
            return await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: syntheticEmail,
              password: syntheticPassword,
            );
          }
          rethrow;
        }
      },
      'PHONE',
      phoneNumberOverride: actualPhone,
    );

    if (user != null) {
      ApitxtService.instance.clear();
    }
    return user;
  }

  /// Tries to sign in or create an account using Firebase Auth.
  /// Returns the User object if sign in was successful.
  Future<BaseAuthUser?> _signInOrCreateAccount(
    BuildContext context,
    Future<UserCredential?> Function() signInFunc,
    String authProvider, {
    String? phoneNumberOverride,
  }) async {
    try {
      final userCredential = await signInFunc();
      if (userCredential?.user != null) {
        await maybeCreateUser(userCredential!.user!,
            phoneNumberOverride: phoneNumberOverride);
      }
      return userCredential == null
          ? null
          : TraviaFirebaseUser.fromUserCredential(userCredential);
    } on FirebaseAuthException catch (e) {
      final errorMsg = switch (e.code) {
        'email-already-in-use' =>
          'Error: The email is already in use by a different account',
        'INVALID_LOGIN_CREDENTIALS' =>
          'Error: The supplied auth credential is incorrect, malformed or has expired',
        'invalid-verification-code' =>
          'The verification code is incorrect. Please double check and try again.',
        'session-expired' =>
          'The verification code has expired. Please request a new code.',
        _ => e.message != null && e.message!.isNotEmpty
            ? 'Error: ${e.message}'
            : 'Authentication error (${e.code}).',
      };
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          backgroundColor: Colors.red.shade700,
        ),
      );
      return null;
    }
  }
}
