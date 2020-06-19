import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/widgets/notification.dart';
import 'package:social/bloc/scroll_to_top_bloc.dart';
import 'package:social/bloc/scrollable_list_bloc/scrollable_list_bloc.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_list_provider.dart';
import 'package:social/data/models/notification.dart';
import 'package:social/data/pagination.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _scrollController = ScrollController();
  ScrollableListBloc _notificationsBloc;
  Completer _completer;
  @override
  initState() {
    super.initState();
    _notificationsBloc = ScrollableListBloc(
      provider: BaseListProvider(
          paginator: Paginator(url: notificationListUrl),
          listFromJson: NotificationModel.listFromJson),
    )..add(LoadList());
    _completer = Completer<void>();
  }

  Widget showList(ScrollableListState state) {
    if (state is ScrollableListInitial || state is ListLoading) {
      return Center(
        child: SpinKitDoubleBounce(color: mediumBlue),
      );
    }
    if (state is ListError) {
      return Center(
        child: Text(state.error.toString()),
      );
    }
    if (state is ListLoaded) {
      if (state.data['list'].isEmpty) {
        return Center(child: Text('No Notifications yet!'));
      } else {
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index < state.data['list'].length) {
              final notification = state.data['list'][index];
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
          itemCount: state.data['list'].length + 1,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding notifications');
    return BlocProvider(
      create: (context) => _notificationsBloc,
      child: BlocConsumer(
        bloc: _notificationsBloc,
        listener: (context, state) {
          if (state is ListLoaded) {
            _completer?.complete();
            _completer = Completer<void>();
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () {
                _notificationsBloc.add(RefreshList());
                return _completer.future;
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: BlocListener<ScrollToTopBloc, ScrollToTopState>(
                  listener: (context, state) {
                    if (state is ScrolledToTop &&
                        state.item == TabItem.notifications) {
                      _scrollController.animateTo(0,
                          duration: Duration(seconds: 1), curve: Curves.ease);
                    }
                  },
                  child: showList(state),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
