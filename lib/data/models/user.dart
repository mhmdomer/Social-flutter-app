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
    @required this.followingMe,
    @required this.followed,
  });

  final int id, followers, following;
  final String name, email, imageUrl, createdAt;
  final bool followingMe, followed;
  static UserModel fromJson(user) {
    return UserModel(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      imageUrl: user['image'],
      followers: user['followerCount'],
      following: user['followingCount'],
      followingMe: user['followingMe'],
      followed: user['followed'],
      createdAt: user['created_at'],
    );
  }
}
