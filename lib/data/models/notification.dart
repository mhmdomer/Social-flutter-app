import 'package:flutter/material.dart';
import 'package:social/UI/widgets/notification.dart';

class NotificationModel {
  NotificationModel({@required this.type, @required this.user, @required this.subject});
  final NotificationType type;
  final user;
  final subject;

  static List<NotificationModel> fromJson(json) {

  }

}