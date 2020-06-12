import 'package:flutter/material.dart';
import 'package:social/screens/notifications.dart';

class NotificationsNavigator extends StatelessWidget {
  NotificationsNavigator({@required this.navigatorKey}) : assert(navigatorKey != null);
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
            return MaterialPageRoute(builder: (_) => NotificationsPage());
            break;
          default:
            return MaterialPageRoute(builder: (_) => NotificationsPage());
            break;
        }
      },
    );
  }
}