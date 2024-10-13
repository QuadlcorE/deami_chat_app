import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';
import 'screens/registration_page.dart';

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
