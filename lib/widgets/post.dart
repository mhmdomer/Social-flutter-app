import 'package:flutter/material.dart';
import 'package:social/constants.dart';

class PostItem extends StatelessWidget {
  PostItem({@required this.post, @required this.clickable})
      : assert(post != null && clickable != null);
  final bool clickable;
  final post;
  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      Navigator.pushNamed(context, '/post');
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      backgroundImage: AssetImage('assets/avatar1.jpg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Username', style: TextStyle(fontSize: 17)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
                  child: Text('4 minutes ago', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: InkWell(
                onTap: clickable ? _onPressed : null,
                child: Text(
                  post['body'],
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/photo',
                  arguments: 'assets/${post['image']}'),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Image.asset('assets/${post['image']}'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: cornflowerBlue,
                      ),
                      onPressed: () {}),
                  IconButton(
                    icon: Icon(
                      Icons.mode_comment,
                      color: Colors.grey,
                    ),
                    onPressed: () => clickable ? _onPressed : null,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    '1232 Likes',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FlatButton(
                    onPressed: clickable ? _onPressed : null,
                    child: Text(
                      '1232 Comments',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
