import 'package:deami_chat_app/screens/home_screen.dart';
import 'package:deami_chat_app/screens/new_home_screen.dart';
import 'package:deami_chat_app/screens/verification_screen.dart';
import 'package:deami_chat_app/services/auth_gate.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Handle null settings.name
  if (settings.name == null) {
    return MaterialPageRoute(
      builder: (context) => const WelcomeScreen(), // Default route
    );
  }

  // Handle named routes
  switch (settings.name!) {
    case '/':
      return MaterialPageRoute(builder: (context) => const AuthGate());
    case '/registration':
      return MaterialPageRoute(builder: (context) => const RegistrationPage());
    case '/login':
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case '/verification':
      return MaterialPageRoute(
          builder: (context) => const VerificationScreen());
    case '/home':
      // return MaterialPageRoute(builder: (context) => const HomeScreen());
      return MaterialPageRoute(builder: (context) => const NewHomeScreen());
    default:
      return MaterialPageRoute(builder: (context) => const AuthGate());
  }
}
