import 'package:deami_chat_app/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0; // To track the selected label/tab.
  int _currentBottomNavIndex = 0; // To track the selected bottom nav item.

  // Dummy list of chat data
  final List<Map<String, String>> _chats = [
    {'name': 'Alice', 'message': 'Hello!', 'label': 'Friends'},
    {'name': 'Bob', 'message': 'Let\'s meet tomorrow', 'label': 'Work'},
    {'name': 'Charlie', 'message': 'Party time!', 'label': 'Friends'},
    {'name': 'David', 'message': 'New project update', 'label': 'Work'},
    {'name': 'Eve', 'message': 'See you soon!', 'label': 'Family'},
  ];

  // Tabs for sorting chat content by label
  final List<String> _labels = ['All', 'Friends', 'Work', 'Family'];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });
  }

  List<Map<String, String>> _getFilteredChats() {
    if (_selectedTabIndex == 0) return _chats; // 'All' tab selected
    final selectedLabel = _labels[_selectedTabIndex];
    return _chats.where((chat) => chat['label'] == selectedLabel).toList();
  }

  // Helper method to get icon based on the selected index
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hides the back button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Chats',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Implement search functionality here
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Tab Navigation Bar for sorting chats
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _labels.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedTabIndex == index;
                return GestureDetector(
                  onTap: () => _onTabSelected(index),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _labels[index],
                    ),
                  ),
                );
              },
            ),
          ),

          // Chats Section
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredChats().length,
              itemBuilder: (context, index) {
                final chat = _getFilteredChats()[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(
                    chat['name']!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    chat['message']!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    // Handle chat item click
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          // Actual Navigationabar
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

          // Positioned circle for Selected Icon
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.elasticInOut,
            bottom: 20, // Adjusted bottom padding
            left: (_currentBottomNavIndex + 0.5) *
                    (MediaQuery.of(context).size.width / 4) -
                30, // Centered dynamically
            child: CircleAvatar(
              radius: 30,
              backgroundColor: ColorUtils.yellow,
              child: Icon(
                _getIconForIndex(_currentBottomNavIndex),
                size: 30,
                color: ColorUtils.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
