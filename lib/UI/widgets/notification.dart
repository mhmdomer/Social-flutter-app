import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';

enum NotificationType { likedYourPost, commentedOnYourPost, likedYourComment }

class NotificationItem extends StatelessWidget {
  NotificationItem({@required this.type, @required this.user, @required this.post});
  final NotificationType type;
  final user;
  final post;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: [cornflowerBlue, Colors.transparent][Random().nextInt(2)],
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/post', arguments: post);
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: user['image'] != null ? NetworkImage(user['image']) : AssetImage('assets/avatar1.jpg'),
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: '${user['name']} ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: getText(type), style: TextStyle()),
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
        return 'commented on your post ';
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
