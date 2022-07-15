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
    apiKey: 'AIzaSyACq3umLyTDjaSnTDPPSn4OQA8mx0m5IyI',
    appId: '1:95292600321:web:d14690b632630a3a1d9000',
    messagingSenderId: '95292600321',
    projectId: 'flutter-chat-c1ccd',
    authDomain: 'flutter-chat-c1ccd.firebaseapp.com',
    storageBucket: 'flutter-chat-c1ccd.appspot.com',
    measurementId: 'G-4C3FG8VP0C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBq2vyMYli7IPBjDD7LdyKQfw2tF5_4oA',
    appId: '1:95292600321:android:83ea824d7fba5bea1d9000',
    messagingSenderId: '95292600321',
    projectId: 'flutter-chat-c1ccd',
    storageBucket: 'flutter-chat-c1ccd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJ0Gy3Hm5Q8jvO30uo6hcu5rKbskeYhtI',
    appId: '1:95292600321:ios:d862465d03dd46471d9000',
    messagingSenderId: '95292600321',
    projectId: 'flutter-chat-c1ccd',
    storageBucket: 'flutter-chat-c1ccd.appspot.com',
    iosClientId: '95292600321-be5m1ls30vdsomp2e7312dgb3e1fhf54.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatWithUs',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJ0Gy3Hm5Q8jvO30uo6hcu5rKbskeYhtI',
    appId: '1:95292600321:ios:d862465d03dd46471d9000',
    messagingSenderId: '95292600321',
    projectId: 'flutter-chat-c1ccd',
    storageBucket: 'flutter-chat-c1ccd.appspot.com',
    iosClientId: '95292600321-be5m1ls30vdsomp2e7312dgb3e1fhf54.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatWithUs',
  );
}