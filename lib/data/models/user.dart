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

  final int id, followers, following, createdAt;
  final String name, email, imageUrl;

  static UserModel fromJson(json) {

  }
}
