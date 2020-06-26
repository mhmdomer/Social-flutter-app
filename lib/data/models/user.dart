import 'package:flutter/material.dart';

class UserModel {
  UserModel({
    @required this.id,
    @required this.followers,
    @required this.following,
    @required this.createdAt,
    @required this.name,
    @required this.email,
    @required this.imageUrl,
  });

  final int id, followers, following;
  final String name, email, imageUrl, createdAt;

  static UserModel fromJson(user) {
    return UserModel(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      imageUrl: user['image'],
      followers: user['followerCount'],
      following: user['followingCount'],
      createdAt: user['created_at'],
    );
  }
}
