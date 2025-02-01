import 'package:deami_chat_app/models/chat_category.dart';
import 'package:flutter/material.dart';
import 'package:deami_chat_app/constants/colors.dart';

class TabNavigationBar extends StatefulWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;
  final List<ChatCategory> categories;
  final Map<String, int> categoryCount;

  const TabNavigationBar(
      {super.key,
      required this.onTabSelected,
      required this.categories,
      required this.categoryCount,
      required this.selectedIndex});

  @override
  State<TabNavigationBar> createState() => _TabNavigationBarState();
}

class _TabNavigationBarState extends State<TabNavigationBar> {
  // final List<String> _labels = ['All chats', 'Work', 'Friends', 'Family'];
  final GlobalKey _tabsKey = GlobalKey();
  final List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();
    _initializeTabKeys();
    // Position indicator after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndicatorPosition(widget.selectedIndex);
    });
  }

  void _initializeTabKeys() {
    _tabKeys.clear();
    for (var i = 0; i < widget.categories.length; i++) {
      _tabKeys.add(GlobalKey());
    }
  }

  @override
  void didUpdateWidget(TabNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categories.length != widget.categories.length) {
      _initializeTabKeys();
    }
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _updateIndicatorPosition(widget.selectedIndex);
    }
  }

  void _updateIndicatorPosition(int index) {
    final RenderBox? tabsBox =
        _tabsKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? tabBox =
        _tabKeys[index].currentContext?.findRenderObject() as RenderBox?;

    if (tabsBox == null || tabBox == null) return;
  }

  void _onTabSelected(int index) {
    widget.onTabSelected(index);
    _updateIndicatorPosition(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        key: _tabsKey,
        children: [
          // Tab Items
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              final category = widget.categories[index];
              final count = widget.categoryCount[category.id] ?? 0;

              return GestureDetector(
                key: _tabKeys[index],
                onTap: () => _onTabSelected(index),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Text(
                        category.name,
                        style: TextStyle(
                          fontWeight: widget.selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: widget.selectedIndex == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                      if (count > 0) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),

          // Bottom line
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 3,
              color: ColorUtils.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
