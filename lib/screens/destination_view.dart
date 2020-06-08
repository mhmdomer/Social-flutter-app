

import 'package:flutter/material.dart';
import 'package:social/helpers/destination.dart';
import 'package:social/helpers/navigator_observer.dart';
import 'package:social/screens/list_page.dart';
import 'package:social/screens/root_page.dart';
import 'package:social/screens/text_page.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({ Key key, this.destination, this.onNavigation }) : super(key: key);

  final Destination destination;
  final VoidCallback onNavigation;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: <NavigatorObserver>[
        ViewNavigatorObserver(widget.onNavigation),
      ],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return RootPage(destination: widget.destination);
              case '/list':
                return ListPage(destination: widget.destination);
              case '/text':
                return TextPage(destination: widget.destination);
            }
          },
        );
      },
    );
  }
}