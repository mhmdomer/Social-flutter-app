import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_provider.dart';
import 'package:social/data/models/user.dart';

class UserApiProvider extends BaseProvider {

  createUser(credentials) async {
    final dio = Dio();
    dio.options.headers['Accept'] = 'application/json';
    try {
      final response = await dio.post('$baseUrl/register', data: credentials);
      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', token);
        return UserModel.fromJson(response.data);
      } else {
        throw response.data['message'];
      }
    } on DioError catch (e) {
      if(e.response != null) {
        throw e.response.data['errors'];
      } else if(e.error is SocketException) {
        throw 'Check Your internet connection and try again!';
      } else {
        throw 'Sorry Something went wrong!';
      }
    }
  }

  loginUser(credentials) async {
    final dio = Dio();
    dio.options.headers['Accept'] = 'application/json';
    try {
      final response = await dio.post('$baseUrl/login', data: credentials);
      print(response.data);
      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', token);
        return UserModel.fromJson(response.data);
      } else {
        throw response.data['message'];
      }
    } on DioError catch(e) {
      if(e.response != null) {
        throw e.response.data;
      } else if(e.error is SocketException) {
        throw 'Check Your internet connection and try again!';
      } else {
        throw 'Sorry Something went wrong!';
      }
    }
  }

  Future<UserModel> getUser(id) async {
    final response = await client.get('$baseUrl/users/$id');
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }
}
