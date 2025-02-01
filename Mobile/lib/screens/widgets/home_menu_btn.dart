import 'package:deami_chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';

// This is the type used by the popup menu below.
enum Menu { signout }

class HomeMenuBtn extends StatefulWidget {

  const HomeMenuBtn({super.key});

  @override
  State<HomeMenuBtn> createState() => _PopupMenuExampleState();
}

class _PopupMenuExampleState extends State<HomeMenuBtn> {
  Menu? selectedItem;

  void _signOut() {
    final auth = AuthServices();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      initialValue: selectedItem,
      onSelected: (Menu item) {
        if (item == Menu.signout) {
          _signOut(); // Call the sign-out method
        }
        setState(() {
          selectedItem = item; // Update the selected item state (optional)
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        const PopupMenuItem<Menu>(
          value: Menu.signout,
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sign Out"),
          ),
        ),
      ],
    );
  }
}
