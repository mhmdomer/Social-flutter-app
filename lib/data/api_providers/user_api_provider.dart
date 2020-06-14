import 'package:dio/dio.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/models/user.dart';

class UserApiProvider {
  final _client = Dio();

  Future<UserModel> createUser(credentials) async {
    final response = await _client.post('$baseUrl/register', data: credentials);
    if(response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<UserModel> loginUser(credentials) async {
    final response = await _client.post('$baseUrl/login', data: credentials);
    if(response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }


  Future<UserModel> getUser(id) async {
    final response = await _client.get('$baseUrl/users/$id');
    if(response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }
}