import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDOumNJXUSftjw7Qw_ndqL4tXitpEQWVZE",
            authDomain: "traviaapp.firebaseapp.com",
            projectId: "traviaapp",
            storageBucket: "traviaapp.firebasestorage.app",
            messagingSenderId: "943871668803",
            appId: "1:943871668803:web:50e08de7c4f32050a9daf6",
            measurementId: "G-4PXXTGWQGX"));
  } else {
    await Firebase.initializeApp();
  }
}
