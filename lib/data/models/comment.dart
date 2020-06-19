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

  static CommentModel fromJson(comment) {
    return CommentModel(
      id: comment['id'],
      body: comment['body'],
      user: comment['user'],
      postId: comment['post_id'],
      createAt: comment['created_at'],
    );
  }

  static List listFromJson(comments) {
    comments.map((comment) => CommentModel(
      id: comment['id'],
      body: comment['body'],
      user: comment['user'],
      postId: comment['post_id'],
      createAt: comment['created_at'],
    )).toList();
  }

}
