import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Service to handle SMS OTP sending and verification via APITxT (https://apitxt.com)
class ApitxtService {
  ApitxtService._();
  static final ApitxtService instance = ApitxtService._();

  static const String authKey = '_WM9DlQ8GtVMj8Bn8mfW6iWNjqgfyCaXztTEfl4Ctw8';
  static const String sendOtpUrl = 'https://apitxt.com/api/sendOTP';

  String? _currentPhoneNumber;
  String? _currentOtp;
  DateTime? _otpTimestamp;

  String? get currentPhoneNumber => _currentPhoneNumber;
  String? get currentOtp => _currentOtp;

  /// Returns 10-digit clean phone number (e.g. 9876543210) for Indian numbers
  String get clean10DigitPhone {
    if (_currentPhoneNumber == null) return '';
    final digits = _currentPhoneNumber!.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 10) {
      return digits.substring(digits.length - 10);
    }
    return digits;
  }

  /// Returns clean phone number digits without plus (e.g. 919876543210, 14155552671)
  String get cleanPhoneDigits {
    if (_currentPhoneNumber == null) return '';
    return _currentPhoneNumber!.replaceAll(RegExp(r'\D'), '');
  }

  /// Whether current phone is an Indian (+91) number
  bool get isIndianNumber {
    final digits = cleanPhoneDigits;
    return digits.startsWith('91') && digits.length == 12;
  }

  /// Formats any mobile string into the international digits format required by APITxT (e.g., 919876543210, 14155552671)
  String formatForApitxt(String rawPhone) {
    final trimmed = rawPhone.trim();
    if (trimmed.startsWith('+')) {
      return trimmed.substring(1).replaceAll(RegExp(r'\D'), '');
    }
    final digits = trimmed.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10) {
      return '91$digits';
    }
    return digits;
  }

  /// Generate a 6-digit random verification code
  String generate6DigitOtp() {
    final random = Random.secure();
    final code = 100000 + random.nextInt(900000);
    return code.toString();
  }

  /// Sends 6-digit OTP code to the provided mobile number using APITxT POST API
  Future<Map<String, dynamic>> sendOtp(String rawPhone) async {
    try {
      final formattedMobile = formatForApitxt(rawPhone);
      if (formattedMobile.length < 7 || formattedMobile.length > 15) {
        return {
          'success': false,
          'message': 'Please enter a valid phone number with country code.',
        };
      }

      final generatedOtp = generate6DigitOtp();

      final response = await http.post(
        Uri.parse(sendOtpUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'authkey': authKey,
          'mobile': formattedMobile,
          'otp': generatedOtp,
        },
      ).timeout(const Duration(seconds: 15));

      if (kDebugMode) {
        print('APITxT response (${response.statusCode}): ${response.body}');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        dynamic responseData;
        try {
          responseData = jsonDecode(response.body);
        } catch (_) {
          responseData = null;
        }

        final status = responseData is Map ? responseData['status']?.toString().toLowerCase() : null;
        final message = responseData is Map ? responseData['message']?.toString() : response.body;

        if (status == 'success' || (message != null && message.toLowerCase().contains('success'))) {
          // Normalize stored phone representation to standard E.164 (+<country_code><number>)
          _currentPhoneNumber = '+$formattedMobile';
          _currentOtp = generatedOtp;
          _otpTimestamp = DateTime.now();

          return {
            'success': true,
            'message': message ?? 'OTP sent successfully',
            'data': responseData is Map ? responseData['data'] : null,
          };
        } else {
          return {
            'success': false,
            'message': message ?? 'Failed to send OTP via SMS. Please try again.',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server error (${response.statusCode}) while sending OTP.',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error calling APITxT sendOTP: $e');
      }
      return {
        'success': false,
        'message': 'Network error while sending OTP. Please check your connection.',
      };
    }
  }

  /// Verifies user-entered OTP against the in-memory active code
  Map<String, dynamic> verifyOtp(String enteredCode) {
    final trimmed = enteredCode.trim();
    if (_currentOtp == null || _otpTimestamp == null) {
      return {
        'success': false,
        'message': 'No verification code found. Please request a new OTP.',
      };
    }

    // Expiration check: 5 minutes
    final diff = DateTime.now().difference(_otpTimestamp!);
    if (diff.inMinutes >= 5) {
      return {
        'success': false,
        'message': 'Verification code has expired. Please request a new code.',
      };
    }

    if (trimmed == _currentOtp) {
      return {
        'success': true,
        'message': 'OTP verified successfully!',
      };
    } else {
      return {
        'success': false,
        'message': 'The verification code is incorrect. Please check and try again.',
      };
    }
  }

  /// Clear the OTP session
  void clear() {
    _currentOtp = null;
    _otpTimestamp = null;
  }
}
