import 'package:flutter/material.dart';
// import 'package:deami_chat_app/constants/colors.dart';
import 'package:deami_chat_app/models/chat_category.dart';
import 'package:deami_chat_app/screens/home_screens/chat screen/widgets/tab_navigation.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedTabIndex = 0;


  // List of available categories
  final List<ChatCategory> _categories = [
    ChatCategory(id: "all", name: "All chats"),
    ChatCategory(id: 'work', name: 'Work'),
    ChatCategory(id: 'friends', name: 'Friends'),
    ChatCategory(id: 'family', name: 'Family'),
  ];

  // Dummy chat data
  final List<Map<String, String>> _chats = [
    {'name': 'Alice', 'message': 'Hello!', 'label': 'friends'},
    {'name': 'Bob', 'message': 'Let\'s meet tomorrow', 'label': 'work'},
    {'name': 'Charlie', 'message': 'Party time!', 'label': 'friends'},
    {'name': 'David', 'message': 'New project update', 'label': 'work'},
    {'name': 'Eve', 'message': 'See you soon!', 'label': 'family'},
  ];

  // Get only active categories
  List<ChatCategory> get activeCategories =>
      _categories.where((category) => category.isActive).toList();

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _addNewCategory(String name) {
    setState(() {
      _categories.add(
        ChatCategory(
          id: name.toLowerCase().replaceAll(' ', '_'),
          name: name,
        ),
      );
    });
  }

  void _removeCategory(String categoryId) {
    if (categoryId == 'all') return; // Prevent removing "All chats"

    setState(() {
      _categories.removeWhere((category) => category.id == categoryId);
      // Reset to "All chats" if the current category is removed
      if (_categories[_selectedTabIndex].id == categoryId) {
        _selectedTabIndex = 0;
      }
    });
  }

  void _toggleCategoryVisibility(String categoryId) {
    if (categoryId == 'all') return; // Prevent hiding "All chats"

    setState(() {
      final index =
          _categories.indexWhere((category) => category.id == categoryId);
      if (index != -1) {
        _categories[index] = _categories[index].copyWith(
          isActive: !_categories[index].isActive,
        );
      }
      // Reset to "All chats" if the current category is hidden
      if (!_categories[_selectedTabIndex].isActive) {
        _selectedTabIndex = 0;
      }
    });
  }

  List<Map<String, String>> _getFilteredChats() {
    final selectedCategory = activeCategories[_selectedTabIndex];
    if (selectedCategory.id == 'all') return _chats;
    return _chats
        .where((chat) => chat['label'] == selectedCategory.id)
        .toList();
  }

  Map<String, int> _getCategoryCounts() {
    Map<String, int> counts = {};
    for (var category in _categories) {
      counts[category.id] = category.id == 'all'
          ? _chats.length
          : _chats.where((chat) => chat['label'] == category.id).length;
    }
    return counts;
  }

  void _showAddCategoryDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Category'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Category Name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _addNewCategory(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showManageCategoriesSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Manage Categories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...List.generate(
              _categories.length,
              (index) => ListTile(
                title: Text(_categories[index].name),
                leading: Checkbox(
                  value: _categories[index].isActive,
                  onChanged: _categories[index].id == 'all'
                      ? null
                      : (value) {
                          _toggleCategoryVisibility(_categories[index].id);
                          setState(() {}); // Update bottom sheet UI
                        },
                ),
                trailing: _categories[index].id == 'all'
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _removeCategory(_categories[index].id);
                          setState(() {}); // Update bottom sheet UI
                        },
                      ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add New Category'),
              onTap: () {
                Navigator.pop(context);
                _showAddCategoryDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabNavigationBar(
          selectedIndex: _selectedTabIndex,
          onTabSelected: _onTabSelected,
          categories: activeCategories,
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
