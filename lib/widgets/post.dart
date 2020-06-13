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
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: greyBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
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
                    Text('Username'),
                  ],
                ),
                FlatButton(
                  child: Text(
                    'follow',
                    style: TextStyle(color: cornflowerBlue),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child:
                  Text(post['body'], style: TextStyle(color: Colors.black54)),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.asset('assets/${post['image']}'),
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
                    onPressed: () => Navigator.pushNamed(context, '/post'),
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
                        fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FlatButton(
                    onPressed: clickable ? _onPressed : null,
                    child: Text(
                      '1232 Comments',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
              child: Text('4 minutes ago.', style: TextStyle(fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
