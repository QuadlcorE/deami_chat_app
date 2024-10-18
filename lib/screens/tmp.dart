import 'package:flutter/material.dart';
import 'screens/chats_screen.dart';
import 'screens/groups_screen.dart';
import 'screens/calls_screen.dart';
import 'screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBottomNavIndex = 0;
  final PageController _pageController = PageController();

  // List of screen widgets
  final List<Widget> _screens = const [
    ChatsScreen(),
    GroupsScreen(),
    CallsScreen(),
    SettingsScreen(),
  ];

  // Helper method to get the AppBar for the current screen
  AppBar _getAppBarForCurrentScreen(int index) {
    switch (index) {
      case 0:
        return const ChatsScreen().buildAppBar();
      case 1:
        return const GroupsScreen().buildAppBar();
      case 2:
        return const CallsScreen().buildAppBar();
      case 3:
        return const SettingsScreen().buildAppBar();
      default:
        return AppBar(title: const Text('Deami Chat App'));
    }
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBarForCurrentScreen(_currentBottomNavIndex),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
