import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/UI/constants.dart';
import 'package:social/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:social/bloc/scroll_bloc/scroll_to_top_bloc.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/widgets/notification.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social/data/api_providers/notification_api_provider.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _scrollController = ScrollController();
  NotificationsBloc _notificationsBloc;
  Completer _refreshCompleter;
  @override
  initState() {
    super.initState();
    _notificationsBloc = NotificationsBloc(provider: NotificationApiProvider())
      ..add(LoadNotifications());
    _refreshCompleter = Completer();
  }

  Widget showList(NotificationsState state) {
    if (state is NotificationsInitial || state is NotificationsLoading) {
      return Center(
        child: SpinKitDoubleBounce(color: mediumBlue),
      );
    }
    if (state is NotificationsError) {
      return Center(
        child: Text(state.error.toString()),
      );
    }
    if (state is NotificationsLoaded) {
      if (state.data['notifications'].isEmpty) {
        return Center(child: Text('No Notifications yet!'));
      } else {
        return ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index < state.data['notifications'].length) {
              final notification = state.data['notifications'][index];
              print(notification.type);
              return NotificationItem(
                post: notification.post,
                type: notification.type,
                user: notification.user,
              );
            } else if (state.data['hasMore']) {
              return Container(
                padding: EdgeInsets.all(14),
                child: Center(child: SpinKitDoubleBounce(color: mediumBlue)),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text('No more Notifications.'),
                ),
              );
            }
          },
          itemCount: state.data['notifications'].length + 1,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding notifications');
    return RefreshIndicator(
      onRefresh: () {
        _notificationsBloc =
            NotificationsBloc(provider: NotificationApiProvider())
              ..add(LoadNotifications());
        return _refreshCompleter.future;
      },
      child: BlocProvider(
        create: (context) => _notificationsBloc,
        child: BlocConsumer(
          listener: (context, state) {
            if(state is NotificationsLoaded) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) =>
              BlocListener<ScrollToTopBloc, ScrollToTopState>(
            listener: (context, state) {
              if (state is ScrolledToTop &&
                  state.item == TabItem.notifications) {
                _scrollController.animateTo(0,
                    duration: Duration(seconds: 1), curve: Curves.ease);
              }
            },
            child: showList(state),
          ),
          bloc: _notificationsBloc,
        ),
      ),
    );
  }
}
