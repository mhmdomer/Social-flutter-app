import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social/constants.dart';

enum NotificationType { likedYourPost, commentedOnYourPost, likedYourComment }

class NotificationItem extends StatelessWidget {
  NotificationItem({@required this.type}) : assert(type != null);
  final NotificationType type;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: [cornflowerBlue, Colors.transparent][Random().nextInt(2)],
      child: ListTile(
        onTap: () {
          
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/avatar1.jpg'),
        ),
        title: RichText(
          text: new TextSpan(
            style: new TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              new TextSpan(text: 'Omer Mustafa ', style: TextStyle(fontWeight: FontWeight.bold)),
              new TextSpan(
                  text: getText(type),
                  style: new TextStyle()),
            ],
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            '1 hour ago',
            style: TextStyle(color: Colors.grey[300]),
          ),
        ),
        trailing: getIcon(type),
      ),
    );
  }

  String getText(type) {
    switch (type) {
      case NotificationType.likedYourPost:
        return 'liked your post';
        break;
      case NotificationType.commentedOnYourPost:
        return 'commented on your post';
        break;
      case NotificationType.likedYourComment:
        return 'liked your comment';
        break;
      default:
        return '';
        break;
    }
  }
  
  Icon getIcon(type) {
    switch (type) {
      case NotificationType.likedYourPost:
      case NotificationType.likedYourComment:
        return Icon(Icons.thumb_up);
        break;
      case NotificationType.commentedOnYourPost:
        return Icon(Icons.comment);
        break;
      default:
        return Icon(Icons.thumb_up);
        break;
    }
  }
}
