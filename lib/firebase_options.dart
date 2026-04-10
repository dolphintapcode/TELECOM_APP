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
    apiKey: 'AIzaSyC86puqR94y96WRyJNgsxVwvieVxnztOzE',
    appId: '1:34181212925:web:67de80fbb0c045d18c2c94',
    messagingSenderId: '34181212925',
    projectId: 'telecom-app-745d8',
    authDomain: 'telecom-app-745d8.firebaseapp.com',
    storageBucket: 'telecom-app-745d8.firebasestorage.app',
    measurementId: 'G-XBJHE2C6Q3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDqWBlZ9tjJBwKyWo38t59f0L6O2HkHUw',
    appId: '1:34181212925:android:e92c78e97d6606ca8c2c94',
    messagingSenderId: '34181212925',
    projectId: 'telecom-app-745d8',
    storageBucket: 'telecom-app-745d8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxNxhL9Vs7YRfkwdgr40OYHXbPGMa6KTw',
    appId: '1:34181212925:ios:6e32e1e7919b5b8a8c2c94',
    messagingSenderId: '34181212925',
    projectId: 'telecom-app-745d8',
    storageBucket: 'telecom-app-745d8.firebasestorage.app',
    iosBundleId: 'com.example.dataonApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxNxhL9Vs7YRfkwdgr40OYHXbPGMa6KTw',
    appId: '1:34181212925:ios:6e32e1e7919b5b8a8c2c94',
    messagingSenderId: '34181212925',
    projectId: 'telecom-app-745d8',
    storageBucket: 'telecom-app-745d8.firebasestorage.app',
    iosBundleId: 'com.example.dataonApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC86puqR94y96WRyJNgsxVwvieVxnztOzE',
    appId: '1:34181212925:web:a6a579613874598a8c2c94',
    messagingSenderId: '34181212925',
    projectId: 'telecom-app-745d8',
    authDomain: 'telecom-app-745d8.firebaseapp.com',
    storageBucket: 'telecom-app-745d8.firebasestorage.app',
    measurementId: 'G-CFVDWTW0XQ',
  );
}
