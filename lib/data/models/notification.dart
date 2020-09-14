import 'package:flutter/material.dart';
import 'package:social/UI/widgets/notification.dart';
import 'package:social/data/models/post.dart';

class NotificationModel {
  NotificationModel(
      {@required this.id,
      @required this.type,
      @required this.user,
      @required this.post});
  final NotificationType type;
  final id;
  final user;
  final PostModel post;

  static List listFromJson(notifications) {
    return notifications
        .map((notification) => NotificationModel(
              type: _mapStringToType(notification['data']['type']),
              id: notification['id'],
              user: notification['data']['user'],
              post: notification['data']['type'] == 'followed_you'
                  ? null
                  : PostModel.fromJson(notification['data']['post']),
            ))
        .toList();
  }

  static NotificationType _mapStringToType(String type) {
    switch (type) {
      case 'commented_on_your_post':
        return NotificationType.commentedOnYourPost;
        break;
      case 'favorited_your_post':
        return NotificationType.likedYourPost;
        break;
      case 'favorited_your_comment':
        return NotificationType.likedYourComment;
      case 'followed_you':
        return NotificationType.followedYou;
        break;
    }
  }
}
