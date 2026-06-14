import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';

import 'serialization_util.dart';
import '../../auth/firebase_auth/auth_util.dart';
import '../cloud_functions/cloud_functions.dart';

import 'package:flutter/foundation.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

export 'push_notifications_handler.dart';
export 'serialization_util.dart';

class UserTokenInfo {
  const UserTokenInfo(this.userPath, this.fcmToken);
  final String userPath;
  final String fcmToken;
}

Stream<UserTokenInfo> getFcmTokenStream(String userPath) =>
    Stream.value(!kIsWeb && (Platform.isIOS || Platform.isAndroid))
        .where((shouldGetToken) => shouldGetToken)
        .asyncMap<String?>(
            (_) => FirebaseMessaging.instance.requestPermission().then(
              (settings) => settings.authorizationStatus ==
              AuthorizationStatus.authorized
              ? FirebaseMessaging.instance.getToken()
              : null,
        ))
        .switchMap((fcmToken) => Stream.value(fcmToken)
        .merge(FirebaseMessaging.instance.onTokenRefresh))
        .where((fcmToken) => fcmToken != null && fcmToken.isNotEmpty)
        .map((token) => UserTokenInfo(userPath, token!));

final fcmTokenUserStream = authenticatedUserStream
    .where((user) => user != null)
    .map((user) => user!.reference.path)
    .distinct()
    .switchMap(getFcmTokenStream)
    .asyncMap((userTokenInfo) async {
  try {
    // Save token directly to Firestore (no Cloud Function needed)
    final userId = userTokenInfo.userPath.split('/').last;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .set({
      'fcmToken': userTokenInfo.fcmToken,
      'fcmTokenUpdated': FieldValue.serverTimestamp(),
      'deviceType': Platform.isIOS ? 'iOS' : 'Android',
    }, SetOptions(merge: true));

    print('✅ FCM token saved via stream for user: $userId');
    return null;
  } catch (e) {
    print('❌ Error saving FCM token via stream: $e');
    return null;
  }
});