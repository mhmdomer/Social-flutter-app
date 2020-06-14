import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';

class FollowCount extends StatelessWidget {
  FollowCount({@required this.count, @required this.title}) : assert(count != null && title != null);
  final int count;
  final String title;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "$count",
          style: TextStyle(
              color: morningBlue, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
