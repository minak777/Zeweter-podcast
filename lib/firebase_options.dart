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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyB8VFiN1zlpHtXs7uZXo4HLv0vdagwjlRE',
    appId: '1:990560201947:web:8ec07baffaf0d399cdf0fe',
    messagingSenderId: '990560201947',
    projectId: 'zeweter-5e751',
    authDomain: 'zeweter-5e751.firebaseapp.com',
    storageBucket: 'zeweter-5e751.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDE5KWBo1LuLhZ2R2Ija7waFUeiBEgW-uo',
    appId: '1:990560201947:android:823a970f864e423dcdf0fe',
    messagingSenderId: '990560201947',
    projectId: 'zeweter-5e751',
    storageBucket: 'zeweter-5e751.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyxpLRhE8RpA7opvkjv9h07qxVALDQM78',
    appId: '1:990560201947:ios:1782a17d1189313ccdf0fe',
    messagingSenderId: '990560201947',
    projectId: 'zeweter-5e751',
    storageBucket: 'zeweter-5e751.appspot.com',
    iosBundleId: 'com.example.zeweterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyxpLRhE8RpA7opvkjv9h07qxVALDQM78',
    appId: '1:990560201947:ios:1782a17d1189313ccdf0fe',
    messagingSenderId: '990560201947',
    projectId: 'zeweter-5e751',
    storageBucket: 'zeweter-5e751.appspot.com',
    iosBundleId: 'com.example.zeweterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB8VFiN1zlpHtXs7uZXo4HLv0vdagwjlRE',
    appId: '1:990560201947:web:8073b45f60588764cdf0fe',
    messagingSenderId: '990560201947',
    projectId: 'zeweter-5e751',
    authDomain: 'zeweter-5e751.firebaseapp.com',
    storageBucket: 'zeweter-5e751.appspot.com',
  );
}