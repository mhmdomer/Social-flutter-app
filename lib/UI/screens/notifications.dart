import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/UI/helpers/scrollable_list_mixin.dart';
import 'package:social/UI/helpers/showList.dart';
import 'package:social/UI/screens/home.dart';
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

class _NotificationsPageState extends State<NotificationsPage> with ScrollableListMixin {

  @override
  initState() {
    super.initState();
    bloc = ScrollableListBloc(
      provider: BaseListProvider(
          paginator: Paginator(url: notificationListUrl),
          listFromJson: NotificationModel.listFromJson),
    )..add(LoadList());
    initScrollableList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer(
        bloc: bloc,
        listener: (context, state) {
          if (state is ListLoaded) {
            completeCompleter();
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () {
                bloc.add(RefreshList());
                return completerFuture();
              },
              child: BlocListener<ScrollToTopBloc, ScrollToTopState>(
                listener: (context, state) {
                  if (state is ScrolledToTop &&
                      state.item == TabItem.notifications) {
                        animateScroll();
                  }
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: getScrollController(),
                  child: showNotificationsList(state),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
