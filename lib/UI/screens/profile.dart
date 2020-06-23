import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/UI/helpers/profile_clipper.dart';
import 'package:social/UI/helpers/showList.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/widgets/follow_count.dart';
import 'package:social/bloc/scroll_to_top_bloc.dart';
import 'package:social/bloc/scrollable_list_bloc/scrollable_list_bloc.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_list_provider.dart';
import 'package:social/data/models/post.dart';
import 'package:social/data/pagination.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.userId});
  final int userId;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _scrollController = ScrollController();
  ScrollableListBloc _bloc;
  Completer _completer;
  @override
  initState() {
    super.initState();
    _bloc = ScrollableListBloc(
      provider: BaseListProvider(
          paginator: Paginator(url: getUserPostsUrl(userId: widget.userId)),
          listFromJson: PostModel.listFromJson),
    )..add(LoadList());
    _completer = Completer<void>();
  }

  Widget getList(ScrollableListState state) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ListLoaded) {
            _completer?.complete();
            _completer = Completer<void>();
          }
        },
        builder: (context, state) {
          return BlocListener<ScrollToTopBloc, ScrollToTopState>(
            listener: (context, state) {
              if (state is ScrolledToTop && state.item == TabItem.profile) {
                _scrollController.animateTo(0,
                    duration: Duration(seconds: 1), curve: Curves.ease);
              }
            },
            child: RefreshIndicator(
              onRefresh: () {
                _bloc.add(RefreshList());
                return _completer.future;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: <Widget>[
                    Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        ClipPath(
                          clipper: ProfileClipper(),
                          child: Container(
                            width: width,
                            height: height * 0.4,
                            child: Image.asset(
                              'assets/post3.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: width * 0.4,
                              height: width * 0.4,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.asset('assets/avatar1.jpg'),
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Username',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'this is the bio this is the bio this is the bio this is the bio this is the bio this is the bio',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FollowCount(
                            count: 1200,
                            title: 'Followers',
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FollowCount(
                            count: 200,
                            title: 'Following',
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: showPostList(state),
                    )
                    // showPostList(state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
