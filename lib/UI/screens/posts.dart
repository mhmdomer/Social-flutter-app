import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/widgets/post.dart';
import 'package:social/bloc/scroll_bloc/scroll_to_top_bloc.dart';
import 'package:social/bloc/scrollable_list_bloc/scrollable_list_bloc.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_list_provider.dart';
import 'package:social/data/models/post.dart';
import 'package:social/data/pagination.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _scrollController = ScrollController();
  ScrollableListBloc _postsBloc;
  Completer _completer;
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _postsBloc = ScrollableListBloc(
      provider: BaseListProvider(
        paginator: Pagination(url: '$baseUrl/posts'),
        listFromJson: PostModel.listFromJson,
      ),
    )..add(LoadList());
    _scrollController.addListener(_onScroll);
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
        return Center(child: Text('No posts yet!'));
      } else {
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index < state.data['list'].length) {
              return PostItem(post: state.data['list'][index], clickable: true);
            } else if (state.data['hasMore']) {
              return Container(
                padding: EdgeInsets.all(14),
                child: Center(child: SpinKitDoubleBounce(color: mediumBlue)),
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

  @override
  Widget build(BuildContext context) {
    print('rebuilding posts');
    return BlocProvider(
      create: (context) => _postsBloc,
      child: BlocConsumer(
        bloc: _postsBloc,
        listener: (context, state) {
          if (state is ListLoaded) {
            _completer?.complete();
            _completer = Completer<void>();
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add post',
              backgroundColor: mediumBlue,
              child: Icon(Icons.add),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('token', null);
                // Navigator.pushNamed(context, '/add_post');
              },
            ),
            body: RefreshIndicator(
              onRefresh: () {
                _postsBloc.add(RefreshList());
                return _completer.future;
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 15),
                child: BlocListener<ScrollToTopBloc, ScrollToTopState>(
                  listener: (context, state) {
                    if (state is ScrolledToTop && state.item == TabItem.posts) {
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

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postsBloc.add(LoadList());
    }
  }
}
