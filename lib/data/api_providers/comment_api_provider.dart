import 'package:dio/dio.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/models/comment.dart';

class CommentApiProvider {
  final _client = Dio();

  Future<List<CommentModel>> getComments(postId) async {
    final response = await _client.get('$baseUrl/posts/$postId/comments');
    if(response.statusCode == 200) {
      return CommentModel.listFromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<CommentModel> addComment(postId, data) async {
    final response = await _client.post('$baseUrl/posts/$postId/comments', data: data);
    if(response.statusCode == 200) {
      return CommentModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<CommentModel> editComment(data, commentId) async {
    final response = await _client.put('$baseUrl/comments/$commentId', data: data);
    if(response.statusCode == 200) {
      return CommentModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> deleteComment(commentId) async {
    final response = await _client.delete('$baseUrl/comments/$commentId');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> favoriteComment(commentId) async {
    final response = await _client.post('$baseUrl/comments/$commentId/favorite');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> unFavoriteComment(commentId) async {
    final response = await _client.delete('$baseUrl/comments/$commentId/unFavorite');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }
}