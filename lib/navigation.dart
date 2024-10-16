import 'package:deami_chat_app/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
    case '/registration':
      return MaterialPageRoute(builder: (context) => const RegistrationPage());
    case '/login':
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case '/verification':
      return MaterialPageRoute(
          builder: (context) => const VerificationScreen());
    default:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }
}
