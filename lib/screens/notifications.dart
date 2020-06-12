import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/bloc/scroll_to_top_bloc.dart';
import 'package:social/screens/home.dart';
import 'package:social/widgets/notification.dart';

class NotificationsPage extends StatelessWidget {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
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
          NotificationItem(),
          NotificationItem(),
          NotificationItem(),
          NotificationItem(),
          NotificationItem(),
        ],
      ),
    );
  }
}
