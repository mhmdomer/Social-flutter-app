import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/screens/home.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentTab, @required this.onTap})
      : assert(currentTab != null && onTap != null);
  final Function onTap;
  final TabItem currentTab;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: mediumBlue,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_size_select_actual, color: _getColor(TabItem.posts)),
          title: Text('Posts', style: TextStyle(color: _getColor(TabItem.posts))),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active, color: _getColor(TabItem.notifications)),
          title: Text('Notifications', style: TextStyle(color: _getColor(TabItem.notifications))),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: _getColor(TabItem.profile)),
          title: Text('Profile', style: TextStyle(color: _getColor(TabItem.profile))),
        )
      ],
    );
  }

  Color _getColor(item) {
    return item == currentTab ? Colors.white : Colors.grey[400];
  }
}
