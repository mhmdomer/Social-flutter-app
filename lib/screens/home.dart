import 'package:flutter/material.dart';
import 'package:social/helpers/scroll_animator.dart';
import 'package:social/screens/notifications.dart';
import 'package:social/screens/posts_navigator.dart';
import 'package:social/screens/profile.dart';
import 'package:social/widgets/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum TabItem { posts, notifications, profile }

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabItem _currentTab = TabItem.posts;
  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.posts: GlobalKey<NavigatorState>(),
    TabItem.notifications: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };
  ScrollAnimator scrollAnimator;
  @override
  initState() {
    super.initState();
    scrollAnimator = ScrollAnimator(ticker: this);
    scrollAnimator.init();
  }

  void _selectTab(index) {
    TabItem tabItem = TabItem.values[index];
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  Future<bool> _onWillPop() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: NotificationListener<ScrollNotification>(
        onNotification: scrollAnimator.handleScrollNotification,
        child: Scaffold(
          bottomNavigationBar: SizeTransition(
            sizeFactor: scrollAnimator.getAnimator(),
            axisAlignment: -1.0,
            child: BottomNavigation(
              currentTab: _currentTab,
              onTap: _selectTab,
            ),
          ),
          body: Stack(children: [
            Offstage(
              offstage: _currentTab != TabItem.posts,
              child:
                  PostsNavigator(navigatorKey: _navigatorKeys[TabItem.posts]),
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
      ),
    );
  }
}
