// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyB5coPOyqT-mzHnd87fD0SpqWz0wrtmdSU',
    appId: '1:884971505642:web:c92148d010998780865493',
    messagingSenderId: '884971505642',
    projectId: 'fcm-test-476a5',
    authDomain: 'fcm-test-476a5.firebaseapp.com',
    storageBucket: 'fcm-test-476a5.appspot.com',
    measurementId: 'G-FR0MJQ7YZN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7joT7aG-X1FtvoNuR8W94pwGipW9zimM',
    appId: '1:884971505642:android:5c376fe1880b943a865493',
    messagingSenderId: '884971505642',
    projectId: 'fcm-test-476a5',
    storageBucket: 'fcm-test-476a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnDX64iKVZCJJbzlxH7D8dwR8MQ_DBUz4',
    appId: '1:884971505642:ios:6fa6cb00c863ed54865493',
    messagingSenderId: '884971505642',
    projectId: 'fcm-test-476a5',
    storageBucket: 'fcm-test-476a5.appspot.com',
    iosBundleId: 'com.example.hankkitoktok.hankkitoktok',
  );

}