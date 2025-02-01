import 'package:deami_chat_app/screens/widgets/home_menu_btn.dart';
import 'package:flutter/material.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Homescreen',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const HomeMenuBtn(),
          ]
        ),
      ),
    );
  }
}
