import 'package:deami_chat_app/screens/home_screen.dart';
import 'package:deami_chat_app/screens/login_screen.dart';
import 'package:deami_chat_app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // User is logged in
            if (snapshot.hasData) {
              return const HomeScreen();
            }

            // User not logged in
            else {
              return const WelcomeScreen();
            }
          }),
    );
  }
}
