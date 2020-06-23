import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/helpers/showList.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/bloc/scroll_to_top_bloc.dart';
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
        paginator: Paginator(url: postListUrl),
        listFromJson: PostModel.listFromJson,
      ),
    )..add(LoadList());
    _scrollController.addListener(_onScroll);
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: showPostList(
                      state,
                    ),
                  ),
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
