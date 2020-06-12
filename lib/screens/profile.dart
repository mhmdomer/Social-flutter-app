import 'package:flutter/material.dart';
import 'package:social/widgets/follow_count.dart';
import 'package:social/widgets/post.dart';
import 'package:social/widgets/profile_clipper.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset('assets/avatar1.jpg'),
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
          ListView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              PostItem(
                post: {
                  'name': 'post1',
                  'image': 'post1.jpg',
                  'body':
                      'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'
                },
              ),
              PostItem(
                post: {
                  'name': 'post2',
                  'image': 'post2.jpg',
                  'body':
                      'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'
                },
              ),
              PostItem(
                post: {
                  'name': 'post3',
                  'image': 'post3.jpg',
                  'body':
                      'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'
                },
              ),
              PostItem(
                post: {
                  'name': 'post4',
                  'image': 'post4.jpg',
                  'body':
                      'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set'
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
