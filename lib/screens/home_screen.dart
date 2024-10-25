import 'package:deami_chat_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:deami_chat_app/screens/home_screens/chat%20screen/chats_screen.dart';
import 'package:deami_chat_app/screens/home_screens/communities_screen.dart';
import 'package:deami_chat_app/screens/home_screens/contact_screen.dart';
import 'package:deami_chat_app/screens/home_screens/account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentBottomNavIndex = 0;
  bool _isSwipe = false;
  bool _isDragging = false;
  int _selectedIconIndex = 0;
  int _pendingNavIndex = 0;

  final PageController _pageController = PageController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(microseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _updateSelectedIcon(int index) {
    setState(() {
      _selectedIconIndex = index;
    });
  }

  // void _onBottomNavTapped(int index) {
  //   _animationController.reverse().then((_) {
  //     setState(() {
  //       _currentBottomNavIndex = index;
  //     });
  //     _pageController.animateToPage(index,
  //         duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  //     _animationController.forward();
  //   });
  // }

  // Add this method to detect drag start
  void _onDragStart() {
    setState(() {
      _isDragging = true;
    });
  }

  // Add this method to detect drag end
  void _onDragEnd() {
    setState(() {
      _isDragging = false;
    });
  }

  // Handle bottom navigation tap and delay state update until animation completes.
  void _onBottomNavTapped(int index) {
    setState(() {
      _isSwipe = false;
      _currentBottomNavIndex = index;
      _pendingNavIndex =
          index; // Set the desired index without updating immediately.
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Modify page change handler
  void _onPageChanged(int index) {
    if (_isDragging) {
      setState(() {
        _isSwipe = true;
        _pendingNavIndex = index;
      });
    }
    setState(() {
      _currentBottomNavIndex = index;
    });
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.chat;
      case 1:
        return Icons.group;
      case 2:
        return Icons.call;
      case 3:
        return Icons.settings;
      default:
        return Icons.chat;
    }
  }

  // Screens for each tab
  final List<Widget> _screens = [
    const ChatsScreen(),
    const CommunitiesScreen(),
    const ContactScreen(),
    const AccountScreen(),
  ];

  AppBar _getAppBarForCurrentScreen(int index) {
    switch (index) {
      case 0:
        return const ChatsScreen().buildAppBar(context);
      case 1:
        return const CommunitiesScreen().buildAppBar(context);
      case 2:
        return const ContactScreen().buildAppBar(context);
      case 3:
        return const AccountScreen().buildAppBar(context);
      default:
        return const ChatsScreen().buildAppBar(context);
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Chats';
      case 1:
        return 'Groups';
      case 2:
        return 'Calls';
      case 3:
        return 'Settings';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBarForCurrentScreen(_currentBottomNavIndex),

      body: Listener(
        onPointerDown: (_) => _onDragStart(),
        onPointerUp: (_) => _onDragEnd(),
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _screens,
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          // Actual Navigation Bar
          BottomNavigationBar(
            currentIndex: _currentBottomNavIndex,
            selectedItemColor: Colors.transparent,
            selectedIconTheme: const IconThemeData(color: Colors.transparent),
            onTap: _onBottomNavTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Groups',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call),
                label: 'Calls',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),

          // Positioned Circle with Animated Text
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.elasticInOut,
            bottom: 5,
            left: (_currentBottomNavIndex + 0.5) *
                    (MediaQuery.of(context).size.width / 4) -
                30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorUtils.yellow,
                  child: Icon(
                    _getIconForIndex(
                        _isSwipe ? _pendingNavIndex : _currentBottomNavIndex),
                    size: 30,
                    color: ColorUtils.black,
                  ),
                ),
                const SizedBox(height: 5),

                // Animated Fade Text
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    _getLabelForIndex(
                        _isSwipe ? _pendingNavIndex : _currentBottomNavIndex),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
