import 'package:flutter/material.dart';

class PostModel {
  PostModel({
    @required this.id,
    @required this.userId,
    @required this.categoryId,
    @required this.body,
    @required this.imageUrl,
    @required this.isFavorited,
    @required this.favoriteCount,
    @required this.commentCount,
    @required this.user,
    @required this.category,
  });

  final int id, userId, categoryId, favoriteCount, commentCount;
  final bool isFavorited;
  final String body, imageUrl;
  final user, category;

  static PostModel fromJson(post) {
    return PostModel(
      id: post['id'],
      userId: post['user_id'],
      categoryId: post['category_id'],
      body: post['body'],
      imageUrl: post['image'],
      isFavorited: post['isFavorited'] != 0,
      favoriteCount: post['favoriteCount'],
      commentCount: post['commentCount'],
      user: post['user'],
      category: post['category'],
    );
  }

  static List listFromJson(posts) {
    return posts.map(
      (post) => PostModel(
        id: post['id'],
        userId: post['user_id'],
        categoryId: post['category_id'],
        body: post['body'],
        imageUrl: post['image'],
        isFavorited: post['isFavorited'] != 0,
        favoriteCount: post['favoriteCount'],
        commentCount: post['commentCount'],
        user: post['user'],
        category: post['category'],
      ),
    ).toList();
  }
}
