import 'package:flutter/material.dart';
import 'package:deami_chat_app/constants/colors.dart';

class TabNavigationBar extends StatefulWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;
  final Map<String, int> categoryCount;

  const TabNavigationBar(
      {super.key,
      required this.onTabSelected,
      required this.categoryCount,
      required this.selectedIndex});

  @override
  State<TabNavigationBar> createState() => _TabNavigationBarState();
}

class _TabNavigationBarState extends State<TabNavigationBar> {
  final List<String> _labels = ['All chats', 'Work', 'Friends', 'Family'];
  final GlobalKey _tabsKey = GlobalKey();
  final List<GlobalKey> _tabKeys = [];
  double _indicatorPosition = 0;
  double _indicatorWidth = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _labels.length; i++) {
      _tabKeys.add(GlobalKey());
    }
    // Position indicator after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndicatorPosition(widget.selectedIndex);
    });
  }

  @override
  void didUpdateWidget(TabNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _updateIndicatorPosition(widget.selectedIndex);
    }
  }

  void _updateIndicatorPosition(int index) {
    final RenderBox tabsBox =
        _tabsKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox tabBox =
        _tabKeys[index].currentContext?.findRenderObject() as RenderBox;
    final tabPosition = tabBox.localToGlobal(Offset.zero, ancestor: tabsBox);

    setState(() {
      _indicatorPosition = tabPosition.dx;
      _indicatorWidth = tabBox.size.width;
    });
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
            itemCount: _labels.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                key: _tabKeys[index],
                onTap: () => _onTabSelected(index),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    _labels[index],
                    style: TextStyle(
                      fontWeight: widget.selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: widget.selectedIndex == index
                          ? Colors.black
                          : Colors.grey,
                    ),
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

          // Sliding indicator
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            bottom: 0,
            left: _indicatorPosition,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _indicatorWidth,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
