import 'package:flutter/material.dart';
import 'package:social/screens/profile.dart';

class ProfileNavigator extends StatelessWidget {
  ProfileNavigator({@required this.navigatorKey}) : assert(navigatorKey != null);
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
            return MaterialPageRoute(builder: (_) => ProfilePage());
            break;
          default:
            return MaterialPageRoute(builder: (_) => ProfilePage());
            break;
        }
      },
    );
  }
}