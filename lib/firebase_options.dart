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
    apiKey: 'AIzaSyConaH2s3Zm66_m8pJ_bEi6bM9kRHh26jI',
    appId: '1:218168390445:web:9e9bc6b6ee4fd70c60d9a4',
    messagingSenderId: '218168390445',
    projectId: 'chat-app-d1ad5',
    authDomain: 'chat-app-d1ad5.firebaseapp.com',
    storageBucket: 'chat-app-d1ad5.appspot.com',
    measurementId: 'G-VN9TXPWSYF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByLqq21hGJzve9l1OSkRvNAWE4zeHksMg',
    appId: '1:218168390445:android:22bcdd5fce59cd9460d9a4',
    messagingSenderId: '218168390445',
    projectId: 'chat-app-d1ad5',
    storageBucket: 'chat-app-d1ad5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy68DvSGM78uiDr2uGYt3KuNn1JohdpI8',
    appId: '1:218168390445:ios:3b10f428a228822960d9a4',
    messagingSenderId: '218168390445',
    projectId: 'chat-app-d1ad5',
    storageBucket: 'chat-app-d1ad5.appspot.com',
    iosBundleId: 'com.example.flutterChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAy68DvSGM78uiDr2uGYt3KuNn1JohdpI8',
    appId: '1:218168390445:ios:39d76bc06c3b9b6560d9a4',
    messagingSenderId: '218168390445',
    projectId: 'chat-app-d1ad5',
    storageBucket: 'chat-app-d1ad5.appspot.com',
    iosBundleId: 'com.example.flutterChatApp.RunnerTests',
  );
}
