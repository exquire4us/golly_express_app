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
    apiKey: 'AIzaSyDp5LMrVPugzT4Fdx8IPc9Yxi2BsmP1sEc',
    appId: '1:1009944030067:web:9952ad4bad871279263306',
    messagingSenderId: '1009944030067',
    projectId: 'golly-express-flutter',
    authDomain: 'golly-express-flutter.firebaseapp.com',
    storageBucket: 'golly-express-flutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmO-OAG97TqmdYdi1CKX94yFQltrd43Kg',
    appId: '1:1009944030067:android:c2152a5b8e432ca7263306',
    messagingSenderId: '1009944030067',
    projectId: 'golly-express-flutter',
    storageBucket: 'golly-express-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDCRAWO7Hcg9EWNgciI3kguTfBhNlzerew',
    appId: '1:1009944030067:ios:7aa9c670e340b540263306',
    messagingSenderId: '1009944030067',
    projectId: 'golly-express-flutter',
    storageBucket: 'golly-express-flutter.appspot.com',
    iosBundleId: 'com.example.gollyExpressApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDCRAWO7Hcg9EWNgciI3kguTfBhNlzerew',
    appId: '1:1009944030067:ios:c7ed8effb56e27c5263306',
    messagingSenderId: '1009944030067',
    projectId: 'golly-express-flutter',
    storageBucket: 'golly-express-flutter.appspot.com',
    iosBundleId: 'com.example.gollyExpressApp.RunnerTests',
  );
}
