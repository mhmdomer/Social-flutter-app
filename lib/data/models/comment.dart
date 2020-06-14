import 'package:flutter/material.dart';

class CommentModel {
  CommentModel({
    @required this.id,
    @required this.postId,
    @required this.body,
    @required this.user,
    @required this.createAt,
  });

  final int id, postId, createAt;
  final user;
  final String body;

  static List<CommentModel> listFromJson(json) {}

  static CommentModel fromJson(json) {}
}
