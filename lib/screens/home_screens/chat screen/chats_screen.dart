import 'package:flutter/material.dart';
import 'package:deami_chat_app/constants/colors.dart';
import 'package:deami_chat_app/screens/home_screens/chat screen/widgets/tab_navigation.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Hides the back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Chats',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
    );
  }

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedTabIndex = 0;

  // Dummy list of chat data
  final List<Map<String, String>> _chats = [
    {'name': 'Alice', 'message': 'Hello!', 'label': 'Friends'},
    {'name': 'Bob', 'message': 'Let\'s meet tomorrow', 'label': 'Work'},
    {'name': 'Charlie', 'message': 'Party time!', 'label': 'Friends'},
    {'name': 'David', 'message': 'New project update', 'label': 'Work'},
    {'name': 'Eve', 'message': 'See you soon!', 'label': 'Family'},
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  // List<Map<String, String>> _getFilteredChats() {
  //   if (_selectedTabIndex == 0) return _chats; // 'All' tab selected
  //   final selectedLabel = _labels[_selectedTabIndex];
  //   return _chats.where((chat) => chat['label'] == selectedLabel).toList();
  // }

  List<Map<String, String>> _getFilteredChats() {
    switch (_selectedTabIndex) {
      case 0: // All chats
        return _chats;
      case 1: // Work
        return _chats.where((chat) => chat['label'] == 'Work').toList();
      case 2: // Friends
        return _chats.where((chat) => chat['label'] == 'Friends').toList();
      case 3: //
        return _chats.where((chat) => chat['label'] == 'Family').toList();
      default:
        return _chats;
    }
  }

  Map<String, int> _getCategoryCounts() {
    return {
      'all': _chats.length,
      'Work': _chats.where((chat) => chat['label'] == 'Work').length,
      'Friends': _chats.where((chat) => chat['label'] == 'Friends').length,
      'Family': _chats.where((chat) => chat['label'] == 'Family').length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabNavigationBar(
          selectedIndex: _selectedTabIndex,
          onTabSelected: _onTabSelected,
          categoryCount: _getCategoryCounts(),
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
    );
  }
}
