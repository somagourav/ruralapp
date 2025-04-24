import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyBuileoI2BrFzQFmAH9hTkgKnIwQez3zhg",
      authDomain: "siplab-7f186.firebaseapp.com",
      projectId: "siplab-7f186",
      storageBucket: "siplab-7f186.appspot.com",
      messagingSenderId: "738325459714",
      appId: "1:738325459714:android:6750debb715381aecdc81b",
    );
  }
}
