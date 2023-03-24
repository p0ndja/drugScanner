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
    apiKey: 'AIzaSyCaLtkq9T8cCv-7CxxozIwyvYrq0V10VNo',
    appId: '1:1058274849558:web:900ef0abc134b7e8f99637',
    messagingSenderId: '1058274849558',
    projectId: 'drugscanner-ae525',
    authDomain: 'drugscanner-ae525.firebaseapp.com',
    storageBucket: 'drugscanner-ae525.appspot.com',
    measurementId: 'G-DW3VCQB536',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJ5UQOt9pVPcRGe9s57zFXSbO3fhHK9_8',
    appId: '1:1058274849558:android:16eec452319ebe2af99637',
    messagingSenderId: '1058274849558',
    projectId: 'drugscanner-ae525',
    storageBucket: 'drugscanner-ae525.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1EFudzx4kL_7wQHYBwgE6ll_O1LEg_Mk',
    appId: '1:1058274849558:ios:f1e3d3646fff500ff99637',
    messagingSenderId: '1058274849558',
    projectId: 'drugscanner-ae525',
    storageBucket: 'drugscanner-ae525.appspot.com',
    iosClientId: '1058274849558-s35vf4jl8svi6q5pr4o5omk2qk8b3tjr.apps.googleusercontent.com',
    iosBundleId: 'com.example.drugScanner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1EFudzx4kL_7wQHYBwgE6ll_O1LEg_Mk',
    appId: '1:1058274849558:ios:f1e3d3646fff500ff99637',
    messagingSenderId: '1058274849558',
    projectId: 'drugscanner-ae525',
    storageBucket: 'drugscanner-ae525.appspot.com',
    iosClientId: '1058274849558-s35vf4jl8svi6q5pr4o5omk2qk8b3tjr.apps.googleusercontent.com',
    iosBundleId: 'com.example.drugScanner',
  );
}