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
    apiKey: 'AIzaSyA6pMXqTBvIlNckvHMdS-Fu0i3m78ZMtuE',
    appId: '1:693980267723:web:01e201e4b8c1d94f4bc74e',
    messagingSenderId: '693980267723',
    projectId: 'mmff-b1592',
    authDomain: 'mmff-b1592.firebaseapp.com',
    storageBucket: 'mmff-b1592.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4-QjOmrFNtNHvDZtCgP8NrOPOtnNAYuw',
    appId: '1:693980267723:android:89783dbd1015969d4bc74e',
    messagingSenderId: '693980267723',
    projectId: 'mmff-b1592',
    storageBucket: 'mmff-b1592.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDUJWES0PVdRm7FToS7hihUAD3rGW2xXr4',
    appId: '1:693980267723:ios:6d43ff353c5b16e34bc74e',
    messagingSenderId: '693980267723',
    projectId: 'mmff-b1592',
    storageBucket: 'mmff-b1592.appspot.com',
    androidClientId: '693980267723-jrc2hsarogvqk5mnvqlu1bv99pq1q9q0.apps.googleusercontent.com',
    iosClientId: '693980267723-7hmenpq870k0m10kom2kt96rnqh7bhn6.apps.googleusercontent.com',
    iosBundleId: 'com.example.auth1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDUJWES0PVdRm7FToS7hihUAD3rGW2xXr4',
    appId: '1:693980267723:ios:6d43ff353c5b16e34bc74e',
    messagingSenderId: '693980267723',
    projectId: 'mmff-b1592',
    storageBucket: 'mmff-b1592.appspot.com',
    androidClientId: '693980267723-jrc2hsarogvqk5mnvqlu1bv99pq1q9q0.apps.googleusercontent.com',
    iosClientId: '693980267723-7hmenpq870k0m10kom2kt96rnqh7bhn6.apps.googleusercontent.com',
    iosBundleId: 'com.example.auth1',
  );
}
