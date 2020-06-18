import 'package:flutter/material.dart';
import 'package:social/UI/widgets/notification.dart';

class NotificationModel {
  NotificationModel({@required this.id, @required this.type, @required this.user, @required this.post});
  final NotificationType type;
  final id;
  final user;
  final post;

  static List<NotificationModel> fromJson(json) {

  }

  static List listFromJson(notifications) {
    print(notifications[0]);
    return notifications.map((notification) => NotificationModel(
      type: _mapStringToType(notification['data']['type']),
      id: notification['id'],
      user: notification['data']['user'],
      post: notification['data']['post'],
    )).toList();
  }

  static NotificationType _mapStringToType(String type) {
    switch(type) {
      case 'commented_on_your_post':
        return NotificationType.commentedOnYourPost;
        break;
      case 'favorited_your_post':
        return NotificationType.likedYourPost;
        break;
      case 'favorited_your_comment':
        return NotificationType.likedYourComment;
        break;
    }
  }

}