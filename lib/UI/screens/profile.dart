import 'package:flutter/material.dart';
import 'package:social/bloc/scroll_to_top_bloc.dart';
import 'package:social/UI/helpers/profile_clipper.dart';
import 'package:social/UI/screens/home.dart';
import 'package:social/UI/widgets/follow_count.dart';
import 'package:social/UI/widgets/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.user_id});
  final int user_id;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    print('rebuilding profile');
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<ScrollToTopBloc, ScrollToTopState>(
      listener: (context, state) {
        if (state is ScrolledToTop && state.item == TabItem.profile) {
          _scrollController.animateTo(0,
              duration: Duration(seconds: 1), curve: Curves.ease);
        }
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  PostItem(
                    clickable: true,
                    post: {
                      'name': 'post1',
                      'image': 'post1.jpg',
                      'body':
                          'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'
                    },
                  ),
                  PostItem(
                    clickable: true,
                    post: {
                      'name': 'post2',
                      'image': 'post2.jpg',
                      'body':
                          'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'
                    },
                  ),
                  PostItem(
                    clickable: true,
                    post: {
                      'name': 'post3',
                      'image': 'post3.jpg',
                      'body':
                          'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'
                    },
                  ),
                  PostItem(
                    clickable: true,
                    post: {
                      'name': 'post4',
                      'image': 'post4.jpg',
                      'body':
                          'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
