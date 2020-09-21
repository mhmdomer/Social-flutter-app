import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/helpers/loading_indicator.dart';
import 'package:social/UI/helpers/profile_clipper.dart';
import 'package:social/UI/helpers/scrollable_list_mixin.dart';
import 'package:social/UI/helpers/showList.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/widgets/button.dart';
import 'package:social/UI/widgets/follow_count.dart';
import 'package:social/bloc/follow_bloc/follow_bloc.dart';
import 'package:social/bloc/profile_bloc.dart';
import 'package:social/bloc/scroll_to_top_bloc.dart';
import 'package:social/bloc/scrollable_list_bloc/scrollable_list_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social/bloc/user_bloc.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_list_provider.dart';
import 'package:social/data/models/post.dart';
import 'package:social/data/pagination.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.userId});
  final int userId;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ScrollableListMixin {
  ProfileBloc _profileBloc;
  FollowBloc _followBloc;
  bool following, clicked;
  int addedFollowCount = 0;
  @override
  initState() {
    super.initState();
    _profileBloc = ProfileBloc()..add(LoadProfile(id: widget.userId));
    bloc = ScrollableListBloc(
      provider: BaseListProvider(
          paginator: Paginator(url: getUserPostsUrl(userId: widget.userId)),
          listFromJson: PostModel.listFromJson),
    )..add(LoadList());
    initScrollableList();
    _followBloc = FollowBloc();
  }

  Widget buildButton(state, followed) {
    if (state is FollowSuccess) {
      // TODO let the button handle the follower count
      following = state.isFollowing;
      if (clicked)
        Future.delayed(Duration(milliseconds: 1)).then((value) => setState(() {
              following && !followed
                  ? addedFollowCount = 1
                  : addedFollowCount = 0;
            }));
      clicked = false;
    }
    return Button(
      text: following ? 'Following' : 'Follow',
      color: following ? mediumBlue : Colors.grey,
      onPress: state is FollowLoading
          ? null
          : () {
              clicked = true;
              _followBloc.add(
                following
                    ? UnFollowUser(userId: widget.userId)
                    : FollowUser(
                        userId: widget.userId,
                      ),
              );
            },
      height: 0,
      width: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bloc,
        ),
        BlocProvider(
          create: (context) => _profileBloc,
        ),
        BlocProvider(
          create: (context) => _followBloc,
        ),
      ],
      child: BlocListener<ScrollToTopBloc, ScrollToTopState>(
        listener: (context, state) {
          if (state is ScrolledToTop && state.item == TabItem.profile) {
            animateScroll();
          }
        },
        child: RefreshIndicator(
          onRefresh: () {
            addedFollowCount = 0;
            _profileBloc.add(LoadProfile(id: widget.userId));
            bloc.add(RefreshList());
            return completerFuture();
          },
          child: SingleChildScrollView(
            controller: getScrollController(),
            child: Column(
              children: <Widget>[
                BlocConsumer(
                  bloc: _profileBloc,
                  listener: (context, state) {
                    if (state is ProfileLoaded) {
                      following = state.user.followed;
                    }
                  },
                  builder: (context, profileState) {
                    if (profileState is ProfileInitial) {
                      return Center(
                        child: getLoadingIndicator(),
                      );
                    }
                    if (profileState is ProfileError) {
                      return Center(
                        child: Text(profileState.error),
                      );
                    }
                    if (profileState is ProfileLoaded) {
                      following = profileState.user.followed;
                      return Column(
                        children: <Widget>[
                          Stack(
                            // overflow: Overflow.visible,
                            children: <Widget>[
                              ClipPath(
                                clipper: ProfileClipper(),
                                child: Container(
                                  width: width,
                                  height: height * 0.4,
                                  child: Image.asset(
                                    'assets/hero.jpg',
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
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child:
                                              profileState.user.imageUrl == null
                                                  ? Image.asset(
                                                      'assets/avatar1.jpg')
                                                  : CachedNetworkImage(
                                                      imageUrl: profileState
                                                          .user.imageUrl,
                                                    ),
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
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
                            profileState.user.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'testing bio',
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
                                  count: profileState.user.followers +
                                      addedFollowCount,
                                  title: 'Followers',
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                FollowCount(
                                  count: profileState.user.following,
                                  title: 'Following',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserFetched &&
                                    state.id != widget.userId)
                                  return BlocConsumer(
                                    listener: (context, state) {
                                      if (state is FollowError) {
                                        Fluttertoast.showToast(
                                          msg: state.error,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }
                                    },
                                    bloc: _followBloc,
                                    builder: (context, state) {
                                      return buildButton(
                                          state, profileState.user.followed);
                                    },
                                  );
                                return Container(width: 0, height: 0);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                        ],
                      );
                    }
                  },
                ),
                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is ListLoaded) {
                      completeCompleter();
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.only(left: 10),
                      child: showList(state, ScrollableType.posts),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
