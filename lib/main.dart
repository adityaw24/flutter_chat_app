import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screen/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_app/screen/list_group_screen.dart';
import 'package:flutter_chat_app/screen/loading_screen.dart';
import 'firebase_options.dart';

final _auth = FirebaseAuth.instance.authStateChanges();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: StreamBuilder(
        stream: _auth,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }

          if (snapshot.hasData) {
            return const ListGroupScreen();
          }

          return const AuthScreen();
        },
      ),
    );
  }
}
