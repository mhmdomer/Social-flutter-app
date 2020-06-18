import 'package:flutter/material.dart';
import 'package:social/bloc/posts_bloc/posts_bloc.dart';
import 'package:social/bloc/scroll_bloc/scroll_to_top_bloc.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/widgets/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/data/api_providers/post_api_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _scrollController = ScrollController();
  PostsBloc _postsBloc;
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _postsBloc = PostsBloc(provider: PostApiProvider())..add(LoadPosts());
    _scrollController.addListener(_onScroll);
  }

  Widget showList(PostsState state) {
    if (state is PostsInitial || state is PostsLoading) {
      return Center(
        child: SpinKitDoubleBounce(color: mediumBlue),
      );
    }
    if (state is PostsError) {
      return Center(
        child: Text(state.error.toString()),
      );
    }
    if (state is PostsLoaded) {
      if (state.data['posts'].isEmpty) {
        return Center(child: Text('No posts yet!'));
      } else {
        return ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index < state.data['posts'].length) {
              return PostItem(
                  post: state.data['posts'][index], clickable: true);
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
          itemCount: state.data['posts'].length + 1,
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
        listener: (context, state) {},
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
            body: Padding(
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
          );
        },
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postsBloc.add(LoadPosts());
    }
  }

}
