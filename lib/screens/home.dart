import 'package:flutter/material.dart';
import 'package:social/constants.dart';
import 'package:social/screens/notifications.dart';
import 'package:social/screens/posts_navigator.dart';
import 'package:social/screens/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum TabItem { posts, notifications, profile }

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.posts;
  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.posts: GlobalKey<NavigatorState>(),
    TabItem.notifications: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        print(isFirstRouteInCurrentTab);
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.posts) {
            // select 'main' tab
            _selectTab(TabItem.posts);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
              _selectTab(TabItem.values[index]);
          },
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
            ),
          ],
        ),
        body: Stack(children: [
          Offstage(
            offstage: _currentTab != TabItem.posts,
            child: PostsNavigator(navigatorKey: _navigatorKeys[TabItem.posts]),
          ),
          Offstage(
            offstage: _currentTab != TabItem.notifications,
            child: NotificationsPage(),
          ),
          Offstage(
            offstage: _currentTab != TabItem.profile,
            child: ProfilePage(),
          ),
        ]),
      ),
    );
  }


  Color _getColor(item) {
    return item == _currentTab ? cornflowerBlue: Colors.grey;
  }
}
