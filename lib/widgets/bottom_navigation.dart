import 'package:flutter/material.dart';
import 'package:social/constants.dart';

BottomNavigationBar bottomNavigation() {
  return BottomNavigationBar(
    backgroundColor: onyx,
    elevation: 6,
    onTap: (index) {
      print(index);
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('Home'),
        activeIcon: Icon(Icons.adb),
        backgroundColor: cornflowerBlue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('Home'),
      ),
    ],
  );
}
