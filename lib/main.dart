import 'package:chat_with_us/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final theme =
      ThemeData(primarySwatch: Colors.pink, backgroundColor: Colors.pink);

  @override
  Widget build(BuildContext context) {
    final initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: initialization,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'FlutterChat',
            theme: theme.copyWith(
                colorScheme:
                    theme.colorScheme.copyWith(secondary: Colors.deepPurple),
                buttonTheme: ButtonTheme.of(context).copyWith(
                    buttonColor: Colors.pink,
                    textTheme: ButtonTextTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))),
            home: snapshot.connectionState != ConnectionState.done
                ? const SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SplashScreen();
                      }
                      if (snapshot.hasData) {
                        return const ChatScreen();
                      }
                      return const AuthScreen();
                    },
                  ),
          );
        });
  }
}
