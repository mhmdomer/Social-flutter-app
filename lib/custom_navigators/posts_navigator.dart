import 'package:flutter/material.dart';
import 'package:social/screens/post_detail.dart';
import 'package:social/screens/posts.dart';

class PostsNavigator extends StatelessWidget {
  PostsNavigator({@required this.navigatorKey}) : assert(navigatorKey != null);
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        String name = settings.name;
        switch(name){
          case '/':
            return MaterialPageRoute(builder: (_) => PostsPage());
            break;
          case '/post':
            return MaterialPageRoute(builder: (_) => PostDetails());
            break;
          default:
            return MaterialPageRoute(builder: (_) => PostsPage());
            break;
        }
      },
    );
  }
}