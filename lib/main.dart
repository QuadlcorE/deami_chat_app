import 'package:deami_chat_app/services/auth_gate.dart';

import 'navigation.dart';
import 'package:flutter/material.dart';
import 'package:deami_chat_app/utils/darktheme.dart';
import 'package:deami_chat_app/utils/lighttheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import 'package:deami/welcome_page.dart';
// import 'package:deami/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeaMi',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      onGenerateRoute: generateRoute,
      // home: const AuthGate(),
    );
  }
}
