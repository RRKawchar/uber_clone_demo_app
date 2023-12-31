// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB56mUGho0HLDiewQuh2VBwO4vKG6kC-do',
    appId: '1:132329117325:web:b6026d950e39fbe0a1b4c4',
    messagingSenderId: '132329117325',
    projectId: 'uber-clone-demo-62902',
    authDomain: 'uber-clone-demo-62902.firebaseapp.com',
    storageBucket: 'uber-clone-demo-62902.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANqoV1XafLGr-VoWUZ1Xo2UTr3ecQ4HFU',
    appId: '1:132329117325:android:4d645a4deb9dd0dfa1b4c4',
    messagingSenderId: '132329117325',
    projectId: 'uber-clone-demo-62902',
    storageBucket: 'uber-clone-demo-62902.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOnAXeFaNDRcC9yhdutMn-vvWgAmd3Y4s',
    appId: '1:132329117325:ios:22afd6199a0c9528a1b4c4',
    messagingSenderId: '132329117325',
    projectId: 'uber-clone-demo-62902',
    storageBucket: 'uber-clone-demo-62902.appspot.com',
    iosBundleId: 'com.example.uberCloneDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOnAXeFaNDRcC9yhdutMn-vvWgAmd3Y4s',
    appId: '1:132329117325:ios:2b3e32b09ce9ebd2a1b4c4',
    messagingSenderId: '132329117325',
    projectId: 'uber-clone-demo-62902',
    storageBucket: 'uber-clone-demo-62902.appspot.com',
    iosBundleId: 'com.example.uberCloneDemo.RunnerTests',
  );
}
