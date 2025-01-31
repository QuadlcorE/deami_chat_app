// // chat_category.dart
// class ChatCategory {
//   final String id;
//   final String name;
//   bool isActive;

//   ChatCategory({
//     required this.id,
//     required this.name,
//     this.isActive = true,
//   });

//   ChatCategory copyWith({
//     String? id,
//     String? name,
//     bool? isActive,
//   }) {
//     return ChatCategory(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       isActive: isActive ?? this.isActive,
//     );
//   }
// }

// // chats_screen.dart
// import 'package:flutter/material.dart';
// import 'package:deami_chat_app/constants/colors.dart';

// class ChatsScreen extends StatefulWidget {
//   const ChatsScreen({super.key});

//   @override
//   State<ChatsScreen> createState() => _ChatsScreenState();
// }

// class _ChatsScreenState extends State<ChatsScreen> {
//   int _selectedTabIndex = 0;
  
//   // List of available categories
//   List<ChatCategory> _categories = [
//     ChatCategory(id: 'all', name: 'All chats'),
//     ChatCategory(id: 'work', name: 'Work'),
//     ChatCategory(id: 'friends', name: 'Friends'),
//     ChatCategory(id: 'family', name: 'Family'),
//   ];

//   // Dummy chat data
//   final List<Map<String, String>> _chats = [
//     {'name': 'Alice', 'message': 'Hello!', 'label': 'friends'},
//     {'name': 'Bob', 'message': 'Let\'s meet tomorrow', 'label': 'work'},
//     {'name': 'Charlie', 'message': 'Party time!', 'label': 'friends'},
//     {'name': 'David', 'message': 'New project update', 'label': 'work'},
//     {'name': 'Eve', 'message': 'See you soon!', 'label': 'family'},
//   ];

//   // Get only active categories
//   List<ChatCategory> get activeCategories => 
//     _categories.where((category) => category.isActive).toList();

//   void _onTabSelected(int index) {
//     setState(() {
//       _selectedTabIndex = index;
//     });
//   }

//   void _addNewCategory(String name) {
//     setState(() {
//       _categories.add(
//         ChatCategory(
//           id: name.toLowerCase().replaceAll(' ', '_'),
//           name: name,
//         ),
//       );
//     });
//   }

//   void _removeCategory(String categoryId) {
//     if (categoryId == 'all') return; // Prevent removing "All chats"
    
//     setState(() {
//       _categories.removeWhere((category) => category.id == categoryId);
//       // Reset to "All chats" if the current category is removed
//       if (_categories[_selectedTabIndex].id == categoryId) {
//         _selectedTabIndex = 0;
//       }
//     });
//   }

//   void _toggleCategoryVisibility(String categoryId) {
//     if (categoryId == 'all') return; // Prevent hiding "All chats"
    
//     setState(() {
//       final index = _categories.indexWhere((category) => category.id == categoryId);
//       if (index != -1) {
//         _categories[index] = _categories[index].copyWith(
//           isActive: !_categories[index].isActive,
//         );
//       }
//       // Reset to "All chats" if the current category is hidden
//       if (!_categories[_selectedTabIndex].isActive) {
//         _selectedTabIndex = 0;
//       }
//     });
//   }

//   List<Map<String, String>> _getFilteredChats() {
//     final selectedCategory = activeCategories[_selectedTabIndex];
//     if (selectedCategory.id == 'all') return _chats;
//     return _chats.where((chat) => 
//       chat['label'] == selectedCategory.id).toList();
//   }

//   Map<String, int> _getCategoryCounts() {
//     Map<String, int> counts = {};
//     for (var category in _categories) {
//       counts[category.id] = category.id == 'all' 
//           ? _chats.length 
//           : _chats.where((chat) => chat['label'] == category.id).length;
//     }
//     return counts;
//   }

//   void _showAddCategoryDialog() {
//     final TextEditingController controller = TextEditingController();
    
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add New Category'),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(
//             labelText: 'Category Name',
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (controller.text.isNotEmpty) {
//                 _addNewCategory(controller.text);
//                 Navigator.pop(context);
//               }
//             },
//             child: const Text('Add'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showManageCategoriesSheet() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) => ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Manage Categories',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             ...List.generate(
//               _categories.length,
//               (index) => ListTile(
//                 title: Text(_categories[index].name),
//                 leading: Checkbox(
//                   value: _categories[index].isActive,
//                   onChanged: _categories[index].id == 'all' 
//                       ? null 
//                       : (value) {
//                           _toggleCategoryVisibility(_categories[index].id);
//                           setState(() {}); // Update bottom sheet UI
//                         },
//                 ),
//                 trailing: _categories[index].id == 'all'
//                     ? null
//                     : IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () {
//                           _removeCategory(_categories[index].id);
//                           setState(() {}); // Update bottom sheet UI
//                         },
//                       ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.add),
//               title: const Text('Add New Category'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _showAddCategoryDialog();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AppBar(
//           automaticallyImplyLeading: false,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Chats',
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: () {
//                       // Implement search functionality
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.settings),
//                     onPressed: _showManageCategoriesSheet,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         TabNavigationBar(
//           selectedIndex: _selectedTabIndex,
//           onTabSelected: _onTabSelected,
//           categories: activeCategories,
//           categoryCount: _getCategoryCounts(),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: _getFilteredChats().length,
//             itemBuilder: (context, index) {
//               final chat = _getFilteredChats()[index];
//               return ListTile(
//                 leading: const CircleAvatar(
//                   child: Icon(Icons.person),
//                 ),
//                 title: Text(
//                   chat['name']!,
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 subtitle: Text(
//                   chat['message']!,
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 onTap: () {
//                   // Handle chat item click
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Updated TabNavigationBar widget
// class TabNavigationBar extends StatefulWidget {
//   final Function(int) onTabSelected;
//   final int selectedIndex;
//   final List<ChatCategory> categories;
//   final Map<String, int> categoryCount;

//   const TabNavigationBar({
//     super.key,
//     required this.onTabSelected,
//     required this.categories,
//     required this.categoryCount,
//     required this.selectedIndex,
//   });

//   @override
//   State<TabNavigationBar> createState() => _TabNavigationBarState();
// }

// class _TabNavigationBarState extends State<TabNavigationBar> {
//   final GlobalKey _tabsKey = GlobalKey();
//   final List<GlobalKey> _tabKeys = [];
//   double _indicatorPosition = 0;
//   double _indicatorWidth = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeTabKeys();
//     // Position indicator after build is complete
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _updateIndicatorPosition(widget.selectedIndex);
//     });
//   }

//   void _initializeTabKeys() {
//     _tabKeys.clear();
//     for (var i = 0; i < widget.categories.length; i++) {
//       _tabKeys.add(GlobalKey());
//     }
//   }

//   @override
//   void didUpdateWidget(TabNavigationBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.categories.length != widget.categories.length) {
//       _initializeTabKeys();
//     }
//     if (oldWidget.selectedIndex != widget.selectedIndex) {
//       _updateIndicatorPosition(widget.selectedIndex);
//     }
//   }

//   void _updateIndicatorPosition(int index) {
//     final RenderBox? tabsBox =
//         _tabsKey.currentContext?.findRenderObject() as RenderBox?;
//     final RenderBox? tabBox =
//         _tabKeys[index].currentContext?.findRenderObject() as RenderBox?;
    
//     if (tabsBox == null || tabBox == null) return;
    
//     final tabPosition = tabBox.localToGlobal(Offset.zero, ancestor: tabsBox);

//     setState(() {
//       _indicatorPosition = tabPosition.dx;
//       _indicatorWidth = tabBox.size.width;
//     });
//   }

//   void _onTabSelected(int index) {
//     widget.onTabSelected(index);
//     _updateIndicatorPosition(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: Stack(
//         key: _tabsKey,
//         children: [
//           ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: widget.categories.length,
//             itemBuilder: (context, index) {
//               final category = widget.categories[index];
//               final count = widget.categoryCount[category.id] ?? 0;
              
//               return GestureDetector(
//                 key: _tabKeys[index],
//                 onTap: () => _onTabSelected(index),
//                 child: Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Row(
//                     children: [
//                       Text(
//                         category.name,
//                         style: TextStyle(
//                           fontWeight: widget.selectedIndex == index
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                           color: widget.selectedIndex == index
//                               ? Colors.black
//                               : Colors.grey,
//                         ),
//                       ),
//                       if (count > 0) ...[
//                         const SizedBox(width: 4),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 6,
//                             vertical: 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             count.toString(),
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Colors.black54,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 3,
//               color: ColorUtils.lightGrey,
//             ),
//           ),
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             bottom: 0,
//             left: _indicatorPosition,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               width: _indicatorWidth,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: Colors.yellow,
//                 borderRadius: BorderRadius.circular(1.5),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }