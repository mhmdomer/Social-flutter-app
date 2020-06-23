import 'package:flutter/material.dart';
import 'package:social/data/models/comment.dart';

class Comment extends StatelessWidget {
  Comment({this.comment});
  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile', arguments: 1);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: comment.user['image'] == null
                  ? AssetImage('assets/avatar1.jpg')
                  : NetworkImage(comment.user['image']),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: '${comment.user['name']} :  ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              comment.body,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_up, color: comment.isFavorited ? Colors.blue : Colors.grey,),
                    onPressed: () {},
                    iconSize: 18,
                  ),
                  Container(
                    child: Text(
                      '1 hour ago',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
