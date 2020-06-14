import 'package:dio/dio.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/models/post.dart';

class PostApiProvider {
  final _client = Dio();

  Future<List<PostModel>> getPosts() async {
    final response = await _client.get('$baseUrl/posts');
    if(response.statusCode == 200) {
      return PostModel.listFromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<PostModel> getPost(id) async {
    final response = await _client.get('$baseUrl/posts/$id');
    if(response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<PostModel> createPost(data) async {
    final response = await _client.post('$baseUrl/posts', data: data);
    if(response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<PostModel> editPost(id, data) async {
    final response = await _client.put('$baseUrl/posts/$id', data: data);
    if(response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }


  Future<bool> deletePost(id) async {
    final response = await _client.delete('$baseUrl/posts/$id');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> favoritePost(id) async {
    final response = await _client.post('$baseUrl/posts/$id/favorite');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> unFavoritePost(id) async {
    final response = await _client.delete('$baseUrl/posts/$id/unFavorite');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }
}