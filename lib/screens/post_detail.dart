import 'package:flutter/material.dart';
import 'package:social/constants.dart';
import 'package:social/widgets/comment.dart';
import 'package:social/widgets/post.dart';

class PostDetails extends StatefulWidget {
  PostDetails({@required this.id});
  final int id;
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            child: PostItem(
              clickable: false,
              post: {
                'name': 'post3',
                'image': 'post3.jpg',
                'body':
                    'lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set lorem ipsum dolor set',
              },
            ),
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
          Container(
            padding: EdgeInsets.only(bottom: 10, left: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Leave a comment...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
