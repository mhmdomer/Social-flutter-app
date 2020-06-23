import 'package:flutter/material.dart';

class CommentModel {
  CommentModel({
    @required this.id,
    @required this.postId,
    @required this.body,
    @required this.user,
    @required this.isFavorited,
    @required this.favoriteCount,
    @required this.createAt,
  });

  final int id, postId, favoriteCount;
  final bool isFavorited;
  final user;
  final String body, createAt;

  static CommentModel fromJson(comment) {
    return CommentModel(
      id: comment['id'],
      body: comment['body'],
      user: comment['user'],
      isFavorited: comment['isFavorited'] != 0,
      favoriteCount: comment['favoriteCount'],
      postId: comment['post_id'],
      createAt: comment['created_at'],
    );
  }

  static List listFromJson(comments) {
    return comments.map((comment) => CommentModel(
      id: comment['id'],
      body: comment['body'],
      user: comment['user'],
      isFavorited: comment['isFavorited'] != 0,
      favoriteCount: comment['favoriteCount'],
      postId: comment['post_id'],
      createAt: comment['created_at'],
    )).toList();
  }

}
