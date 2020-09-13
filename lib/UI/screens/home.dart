import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/UI/custom_navigators/notifications_navigator.dart';
import 'package:social/UI/custom_navigators/posts_navigator.dart';
import 'package:social/UI/custom_navigators/profile_navigator.dart';
import 'package:social/UI/helpers/scroll_animator.dart';
import 'package:social/UI/widgets/bottom_navigation.dart';
import 'package:social/UI/widgets/drawer.dart';
import 'package:social/bloc/scroll_to_top_bloc.dart';
import 'package:social/bloc/user_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {@required this.id,
      @required this.userName,
      @required this.email,
      @required this.imageUrl});
  final String userName, email, imageUrl;
  final int id;
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
  ScrollToTopBloc _scrollBloc;
  UserBloc userBloc;
  @override
  initState() {
    super.initState();
    scrollAnimator = ScrollAnimator(ticker: this);
    scrollAnimator.init();
    _scrollBloc = BlocProvider.of<ScrollToTopBloc>(context);
    userBloc = UserBloc()
      ..add(SetUserEvent(
        id: widget.id,
        userName: widget.userName,
        email: widget.email,
        imageUrl: widget.imageUrl,
      ));
  }

  void _selectTab(index) {
    TabItem tabItem = TabItem.values[index];
    if (tabItem == _currentTab) {
      _scrollBloc.add(ScrollToTop(item: tabItem));
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  Future<bool> _onWillPop() async {
    print('test');
    final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentTab].currentState.maybePop();
    if (isFirstRouteInCurrentTab) {
      // if not on the 'main' tab
      if (_currentTab != TabItem.posts) {
        // select 'main' tab
        _selectTab(0);
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
        child: BlocProvider(
          create: (context) => userBloc,
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
                child: NotificationsNavigator(
                  navigatorKey: _navigatorKeys[TabItem.notifications],
                ),
              ),
              Offstage(
                offstage: _currentTab != TabItem.profile,
                child: ProfileNavigator(
                  navigatorKey: _navigatorKeys[TabItem.profile],
                  userId: widget.id,
                ),
              ),
            ]),
            drawer: MyDrawer(),
          ),
        ),
      ),
    );
  }
}
