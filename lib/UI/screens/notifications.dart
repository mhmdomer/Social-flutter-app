import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/bloc/scroll_to_top_bloc.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/widgets/notification.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _scrollController = ScrollController();
  
  @override
  Widget build(BuildContext context) {
    print('rebuilding notifications');
    return BlocListener<ScrollToTopBloc, ScrollToTopState>(
      listener: (context, state) {
        if (state is ScrolledToTop && state.item == TabItem.notifications) {
          _scrollController.animateTo(0,
              duration: Duration(seconds: 1), curve: Curves.ease);
        }
      },
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          NotificationItem(type: NotificationType.commentedOnYourPost),
          NotificationItem(type: NotificationType.likedYourComment),
          NotificationItem(type: NotificationType.likedYourPost),
          NotificationItem(type: NotificationType.likedYourComment),
          NotificationItem(type: NotificationType.commentedOnYourPost),
        ],
      ),
    );
  }
}
