import 'package:flutter/material.dart';
import 'package:social/widgets/comment.dart';
import 'package:social/widgets/post.dart';

class PostDetails extends StatefulWidget {
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          PostItem(
            clickable: false,
            post: {
              'name': 'post3',
              'image': 'post3.jpg',
              'body':
                  'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set',
            },
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Comment(),
              Comment(),
              Comment(),
            ],
          ),
        ],
      ),
    );
  }
}
