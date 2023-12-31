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
    apiKey: 'AIzaSyAyPCCkTIsVm6kC51H57ijql65oGTyNDhg',
    appId: '1:615626695548:web:b726f3cc42dd2476483af9',
    messagingSenderId: '615626695548',
    projectId: 'fir-learning-43377',
    authDomain: 'fir-learning-43377.firebaseapp.com',
    storageBucket: 'fir-learning-43377.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEGQqG-53PXRJGbs8e5bY2aDDbCNfWZCk',
    appId: '1:615626695548:android:17f9075d0294f885483af9',
    messagingSenderId: '615626695548',
    projectId: 'fir-learning-43377',
    storageBucket: 'fir-learning-43377.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwP3WXeKPGpfhuw9DxOthn9Qms8OqePOs',
    appId: '1:615626695548:ios:1e65eb74655c5fe3483af9',
    messagingSenderId: '615626695548',
    projectId: 'fir-learning-43377',
    storageBucket: 'fir-learning-43377.appspot.com',
    iosBundleId: 'com.example.firebaseSeries',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwP3WXeKPGpfhuw9DxOthn9Qms8OqePOs',
    appId: '1:615626695548:ios:c8a80794bb9d3fe2483af9',
    messagingSenderId: '615626695548',
    projectId: 'fir-learning-43377',
    storageBucket: 'fir-learning-43377.appspot.com',
    iosBundleId: 'com.example.firebaseSeries.RunnerTests',
  );
}
