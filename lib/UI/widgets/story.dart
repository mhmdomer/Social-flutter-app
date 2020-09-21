import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  Story({this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 6, right: 6),
          height: 200,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, left: 8),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 15,
            backgroundImage: AssetImage('assets/avatar1.jpg'),
          ),
        ),
      ],
    );
  }
}
