// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_web_plugins/url_strategy.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'auth/firebase_auth/firebase_user_provider.dart';
// import 'auth/firebase_auth/auth_util.dart';
//
// import 'backend/push_notifications/push_notifications_util.dart';
// import 'backend/firebase/firebase_config.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import 'flutter_flow/flutter_flow_util.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'flutter_flow/nav/nav.dart';
// import 'index.dart';
//
//
// /// Dev branch
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   GoRouter.optionURLReflectsImperativeAPIs = true;
//   usePathUrlStrategy();
//
//   await initFirebase();
//
//   final appState = FFAppState(); // Initialize FFAppState
//   await appState.initializePersistedState();
//
//   runApp(ChangeNotifierProvider(
//     create: (context) => appState,
//     child: MyApp(),
//   ));
// }
//
// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//   State<MyApp> createState() => _MyAppState();
//
//   static _MyAppState of(BuildContext context) =>
//       context.findAncestorStateOfType<_MyAppState>()!;
// }
//
// class _MyAppState extends State<MyApp> {
//   ThemeMode _themeMode = ThemeMode.system;
//
//   late AppStateNotifier _appStateNotifier;
//   late GoRouter _router;
//   String getRoute([RouteMatch? routeMatch]) {
//     final RouteMatch lastMatch =
//         routeMatch ?? _router.routerDelegate.currentConfiguration.last;
//     final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
//         ? lastMatch.matches
//         : _router.routerDelegate.currentConfiguration;
//     return matchList.uri.toString();
//   }
//
//   List<String> getRouteStack() =>
//       _router.routerDelegate.currentConfiguration.matches
//           .map((e) => getRoute(e))
//           .toList();
//   late Stream<BaseAuthUser> userStream;
//
//   final authUserSub = authenticatedUserStream.listen((_) {});
//   final fcmTokenSub = fcmTokenUserStream.listen((_) {});
//
//   @override
//   void initState() {
//     super.initState();
//
//     _appStateNotifier = AppStateNotifier.instance;
//     _router = createRouter(_appStateNotifier);
//     userStream = traviaFirebaseUserStream()
//       ..listen((user) {
//         _appStateNotifier.update(user);
//       });
//     jwtTokenStream.listen((_) {});
//     Future.delayed(
//       Duration(milliseconds: 1000),
//       () => _appStateNotifier.stopShowingSplashImage(),
//     );
//   }
//
//   @override
//   void dispose() {
//     authUserSub.cancel();
//     fcmTokenSub.cancel();
//     super.dispose();
//   }
//
//   void setThemeMode(ThemeMode mode) => safeSetState(() {
//         _themeMode = mode;
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Travia',
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const [Locale('en', '')],
//       theme: ThemeData(
//         brightness: Brightness.light,
//         scrollbarTheme: ScrollbarThemeData(
//           thumbColor: MaterialStateProperty.resolveWith((states) {
//             if (states.contains(MaterialState.dragged)) {
//               return Color(4281023576);
//             }
//             if (states.contains(MaterialState.hovered)) {
//               return Color(4281023576);
//             }
//             return Color(4281023576);
//           }),
//         ),
//         useMaterial3: false,
//       ),
//       themeMode: _themeMode,
//       routerConfig: _router,
//     );
//   }
// }
//
//
// Future<void> _saveFCMTokenToUserProfile() async {
//   try {
//     // Get current user
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;
//
//     // Get FCM token
//     final token = await FirebaseMessaging.instance.getToken();
//     if (token == null) return;
//
//     print('📱 Saving FCM token for user: ${currentUser.uid}');
//     print('   Token: ${token.substring(0, 20)}...');
//
//     // Save to user document
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(currentUser.uid)
//         .update({
//       'fcmTokens': FieldValue.arrayUnion([token]),
//       'lastTokenUpdate': FieldValue.serverTimestamp(),
//     });
//
//     print('✅ FCM token saved successfully');
//
//   } catch (e) {
//     print('❌ Error saving FCM token: $e');
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

// ✅ ADD THIS - Background notification handler (MUST BE TOP-LEVEL)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("📨 Background notification: ${message.notification?.title}");
}

/// Dev branch
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = traviaFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
        // Save FCM token when user logs in
        if (user != null) {
          _saveFCMTokenToUserProfile(user.uid ?? '');
        }
      });

    jwtTokenStream.listen((_) {});

    // Initialize FCM and save token
    _initializeFCM();

    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });
// Initialize FCM and save token
  Future<void> _initializeFCM() async {
    try {
      // Request notification permission
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('📱 Notification permission: ${settings.authorizationStatus}');

      // Get FCM token
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print('🔑 FCM Token obtained: ${token.substring(0, 20)}...');

        // Save token for current user if logged in
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await _saveFCMTokenToUserProfile(currentUser.uid);
        }
      }

      // Listen for token refresh
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        print('🔄 FCM token refreshed: ${newToken.substring(0, 20)}...');
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          _saveFCMTokenToUserProfile(currentUser.uid, token: newToken);
        }
      });

      // Setup notification handlers
      _setupNotificationHandlers();
    } catch (e) {
      print('❌ FCM initialization error: $e');
    }
  }

// Save FCM token to user's Firestore document
  Future<void> _saveFCMTokenToUserProfile(String userId,
      {String? token}) async {
    try {
      if (userId.trim().isEmpty) {
        print('⚠️ Skipping FCM token save: userId is empty');
        return;
      }

      if (token == null) {
        token = await FirebaseMessaging.instance.getToken();
      }

      if (token == null) {
        print('❌ No FCM token available');
        return;
      }

      print('💾 Saving FCM token for user: $userId');
      print(
          '   Token: ${token.length >= 20 ? token.substring(0, 20) : token}...');

      // ✅ CORRECT: Save as SINGLE field 'fcmToken' (not array)
      await FirebaseFirestore.instance.collection('Users').doc(userId).set({
        'fcmToken': token, // ← SINGLE FIELD, NOT ARRAY
        'fcmTokenUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print('✅ FCM token saved successfully for $userId');
    } catch (e) {
      print('❌ Error saving FCM token: $e');
    }
  }

// Setup notification handlers
  void _setupNotificationHandlers() {
    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📨 Foreground notification received');
      print('   Title: ${message.notification?.title}');
      print('   Body: ${message.notification?.body}');
      print('   Data: ${message.data}');
    });

    // Handle when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📱 App opened from notification');
      print('   Data: ${message.data}');
    });

    // Handle initial notification when app is launched
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('🚀 App launched from notification');
        print('   Data: ${message.data}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Travia',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.dragged)) {
              return Color(4281023576);
            }
            if (states.contains(MaterialState.hovered)) {
              return Color(4281023576);
            }
            return Color(4281023576);
          }),
        ),
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
