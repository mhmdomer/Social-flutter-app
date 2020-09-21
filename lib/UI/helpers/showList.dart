import 'package:flutter/material.dart';
import 'package:social/UI/helpers/loading_indicator.dart';
import 'package:social/UI/widgets/comment.dart';
import 'package:social/UI/widgets/notification.dart';
import 'package:social/UI/widgets/post.dart';
import 'package:social/bloc/scrollable_list_bloc/scrollable_list_bloc.dart';

enum ScrollableType { posts, notifications, comments }

Widget showList(ScrollableListState state, ScrollableType type) {
  if (state is ScrollableListInitial || state is ListLoading) {
    return Center(
      child: getLoadingIndicator(),
    );
  }
  if (state is ListError) {
    return Center(
      child: Text(state.error.toString()),
    );
  }
  if (state is ListLoaded) {
    if (state.data['list'].isEmpty) {
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [Center(child: Text('No items yet!'))],
      );
    } else {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index < state.data['list'].length) {
            return getItemFromType(type: type, state: state, index: index);
          } else if (state.data['hasMore']) {
            return Container(
              padding: EdgeInsets.all(14),
              child: Center(child: getLoadingIndicator()),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text('No more posts.'),
              ),
            );
          }
        },
        itemCount: state.data['list'].length + 1,
      );
    }
  }
}

Widget getItemFromType({ScrollableType type, ListLoaded state, int index}) {
  switch (type) {
    case ScrollableType.posts:
      return PostItem(post: state.data['list'][index], clickable: true);
      break;
    case ScrollableType.comments:
      return Comment(
        comment: state.data['list'][index],
      );
      break;
    case ScrollableType.notifications:
      return NotificationItem(
        notification: state.data['list'][index],
      );
      break;
    default:
  }
}
