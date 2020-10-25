import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

class MyNavigation extends StatelessWidget {
  final int tmpindex;
  final Function(int) updateIndex;

  MyNavigation(
    this.tmpindex,
    this.updateIndex,
  );
  @override
  Widget build(BuildContext context) {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: Color.fromARGB(255, 231, 222, 200),
        selectedItemBorderColor: Color.fromARGB(255, 48, 71, 94),
        selectedItemBackgroundColor: Color.fromARGB(255, 203, 175, 135),
        selectedItemIconColor: Colors.grey[700],
        selectedItemLabelColor: Colors.grey[700],
      ),
      selectedIndex: tmpindex,
      onSelectTab: (index) {
        updateIndex(index);
      },
      items: [
        FFNavigationBarItem(
          iconData: Icons.home,
          label: 'Home',
        ),
        FFNavigationBarItem(
          iconData: Icons.search,
          label: 'Search',
        ),
        FFNavigationBarItem(
          iconData: Icons.add_box,
          label: 'Add',
        ),
        FFNavigationBarItem(
          iconData: Icons.favorite,
          label: 'Likes',
        ),
        FFNavigationBarItem(
          iconData: Icons.account_circle,
          label: 'Account',
        ),
      ],
    );
  }
}
