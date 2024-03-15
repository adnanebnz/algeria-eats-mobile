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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBrQ3Yu7Ih6Pf0ccry9Dkdopwq-XUkrbMk',
    appId: '1:370524490316:web:a42849c21ad23238a502e9',
    messagingSenderId: '370524490316',
    projectId: 'algeriaeats',
    authDomain: 'algeriaeats.firebaseapp.com',
    storageBucket: 'algeriaeats.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZPvTPDhLfRXzykZ80dHfjdttUkRzNhXw',
    appId: '1:370524490316:android:b508b80a9e2234f5a502e9',
    messagingSenderId: '370524490316',
    projectId: 'algeriaeats',
    storageBucket: 'algeriaeats.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDohnflZNK6C-vTqFOdZtp9xH7j1wvM9ak',
    appId: '1:370524490316:ios:9164c628fc3207c1a502e9',
    messagingSenderId: '370524490316',
    projectId: 'algeriaeats',
    storageBucket: 'algeriaeats.appspot.com',
    androidClientId: '370524490316-3vb17h28hblek8np4d9iio4m3eoqut5a.apps.googleusercontent.com',
    iosClientId: '370524490316-qqj997dqhl9e7p7vlcpim11mfnaa2efk.apps.googleusercontent.com',
    iosBundleId: 'com.example.algeriaEats',
  );
}
