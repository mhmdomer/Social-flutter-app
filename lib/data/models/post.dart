import 'package:flutter/material.dart';

class PostModel {
  PostModel({
    @required this.id,
    @required this.userId,
    @required this.categoryId,
    @required this.body,
    @required this.imageUrl,
  });

  final int id;
  final int userId;
  final categoryId;
  final String body;
  final String imageUrl;

  static PostModel fromJson(json) {}

  static List<PostModel> listFromJson(json) {}
}
