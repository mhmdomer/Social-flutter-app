import 'dart:io';

import 'package:dio/dio.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_provider.dart';

class FollowApiProvider extends BaseProvider {
  Future<bool> follow(int userId) async {
    try {
      final response = await client.post('$baseUrl/follow/$userId');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw e.response.data['errors'];
      } else if (e.error is SocketException) {
        throw 'Check Your internet connection and try again!';
      } else {
        throw 'Sorry Something went wrong!';
      }
    }
  }

  Future<bool> unFollow(int userId) async {
    try {
      final response = await client.post('$baseUrl/un_follow/$userId');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw e.response.data['errors'];
      } else if (e.error is SocketException) {
        throw 'Check Your internet connection and try again!';
      } else {
        throw 'Sorry Something went wrong!';
      }
    }
  }
}
