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
    apiKey: 'AIzaSyC9MpUX-ioQ_EQVOLmzB_WJk0ixUOfDKOg',
    appId: '1:670275740425:web:48bf300b93f718bf01e9d8',
    messagingSenderId: '670275740425',
    projectId: 'yapilacaklarnotlar',
    authDomain: 'yapilacaklarnotlar.firebaseapp.com',
    storageBucket: 'yapilacaklarnotlar.appspot.com',
    measurementId: 'G-QGJWY5LFH0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWgEjPwUQjcbl_Gwdh7MIUzY4DHg9Amtk',
    appId: '1:670275740425:android:1bffb3c39c5f191a01e9d8',
    messagingSenderId: '670275740425',
    projectId: 'yapilacaklarnotlar',
    storageBucket: 'yapilacaklarnotlar.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDub3jJgEd0qri3_2tphxLSrLPqdfnFp9A',
    appId: '1:670275740425:ios:6ec10013e67e2ef401e9d8',
    messagingSenderId: '670275740425',
    projectId: 'yapilacaklarnotlar',
    storageBucket: 'yapilacaklarnotlar.appspot.com',
    androidClientId: '670275740425-vs9ei694gfgvj2750iv85li8e46k8tgv.apps.googleusercontent.com',
    iosClientId: '670275740425-rebls3f7rh8oau9ar8g33c8oco974ja8.apps.googleusercontent.com',
    iosBundleId: 'com.yapilacaklarnotlarlisteler',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDub3jJgEd0qri3_2tphxLSrLPqdfnFp9A',
    appId: '1:670275740425:ios:6c3f75785d7339f901e9d8',
    messagingSenderId: '670275740425',
    projectId: 'yapilacaklarnotlar',
    storageBucket: 'yapilacaklarnotlar.appspot.com',
    androidClientId: '670275740425-vs9ei694gfgvj2750iv85li8e46k8tgv.apps.googleusercontent.com',
    iosClientId: '670275740425-sd4fjna7k2ssj9ank0kd6tcpk8iemtif.apps.googleusercontent.com',
    iosBundleId: 'com.example.yapilacaklarnotlarlisteler.RunnerTests',
  );
}
