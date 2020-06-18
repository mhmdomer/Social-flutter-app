import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/widgets/comment.dart';
import 'package:social/UI/widgets/post.dart';
import 'package:social/data/models/post.dart';

class PostDetails extends StatefulWidget {
  PostDetails({@required this.post});
  final PostModel post;
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
              post: widget.post,
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
