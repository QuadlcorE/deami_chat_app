import 'package:flutter/material.dart';
import 'package:deami_chat_app/constants/colors.dart';

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

  // Tabs for sorting chat content by label
  final List<String> _labels = ['All', 'Friends', 'Work', 'Family'];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  List<Map<String, String>> _getFilteredChats() {
    if (_selectedTabIndex == 0) return _chats; // 'All' tab selected
    final selectedLabel = _labels[_selectedTabIndex];
    return _chats.where((chat) => chat['label'] == selectedLabel).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Navigation Bar for sorting chats
        SizedBox(
          height: 50,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _labels.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onTabSelected(index),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _labels[index],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Divider
              Divider(
                thickness: 3,
                color: ColorUtils.lightGrey,
                height: 10,
              )
            ],
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
    );
  }
}
