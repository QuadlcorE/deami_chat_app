import 'package:flutter/material.dart';
import 'package:deami/welcome_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const WelcomePage());
    default:
      return MaterialPageRoute(builder: (context) => const WelcomePage());
  }
}
