import 'package:flutter/material.dart';
import 'package:social/UI/helpers/loading_indicator.dart';
import 'package:social/UI/widgets/comment.dart';
import 'package:social/UI/widgets/post.dart';
import 'package:social/bloc/scrollable_list_bloc/scrollable_list_bloc.dart';

Widget showPostList(ScrollableListState state) {
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
        return Center(child: Text('No posts yet!'));
      } else {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // controller: _scrollController,
          itemBuilder: (context, index) {
            if (index < state.data['list'].length) {
              return PostItem(post: state.data['list'][index], clickable: true);
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

  Widget showCommentList(ScrollableListState state) {
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
      print(state.data);
      if (state.data['list'].isEmpty) {
        return Center(child: Text('No comments yet!'));
      } else {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          // controller: _scrollController,
          itemBuilder: (context, index) {
            if (index < state.data['list'].length) {
              return Comment(
                comment: state.data['list'][index],
              );
            } else if (state.data['hasMore']) {
              return Container(
                padding: EdgeInsets.all(14),
                child: Center(child: getLoadingIndicator()),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text('No more comments.'),
                ),
              );
            }
          },
          itemCount: state.data['list'].length + 1,
        );
      }
    }
  }