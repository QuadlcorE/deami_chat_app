import 'package:flutter/material.dart';
import 'package:deami/screens/welcome_page.dart';
import 'package:deami/screens/registration_page.dart';
import 'package:deami/screens/verification_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const WelcomePage());
    case '/registration_page':
      return MaterialPageRoute(builder: (context) => const RegistrationPage());
    default:
      return MaterialPageRoute(builder: (context) => const WelcomePage());
  }
}
