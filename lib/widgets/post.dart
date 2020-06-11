import 'package:flutter/material.dart';
import 'package:social/constants.dart';

class PostItem extends StatelessWidget {
  PostItem({@required this.post}) : assert(post != null);
  final post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: greyBlue,
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
                    SizedBox(width: 10,),
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
                  // topLeft: Radius.circular(15),
                  // bottomLeft: Radius.circular(15)),
              child: Image.asset('assets/${post['image']}'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.thumb_up, color: cornflowerBlue,), onPressed: () {}),
                  IconButton(icon: Icon(Icons.mode_comment, color: Colors.grey,), onPressed: () {}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Text('4 minutes ago.', style: TextStyle(fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
