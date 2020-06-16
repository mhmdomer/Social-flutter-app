import 'package:flutter/material.dart';
import 'package:social/UI/screens/add_post.dart';
import 'package:social/UI/screens/photo_viewer.dart';
import 'package:social/UI/screens/post_detail.dart';
import 'package:social/UI/screens/posts.dart';
import 'package:social/UI/screens/profile.dart';

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
            if(settings.arguments is int) {
              return MaterialPageRoute(builder: (_) => PostDetails(id: settings.arguments));
            }
            break;
          case '/photo':
            if(settings.arguments is String) {
              return MaterialPageRoute(builder: (_) => PhotoViewer(imageUrl: settings.arguments));
            }
            break;
          case '/add_post':
            return MaterialPageRoute(builder: (_) => AddPost());
            break;
          case '/profile':
            if (settings.arguments is int) {
              return MaterialPageRoute(builder: (_) => ProfilePage(userId: settings.arguments));
            }
            break;
          default:
            return MaterialPageRoute(builder: (_) => PostsPage());
            break;
        }
      },
    );
  }
}