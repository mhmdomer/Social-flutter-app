import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_provider.dart';
import 'package:social/data/models/comment.dart';

class CommentApiProvider extends BaseProvider{

  Future<CommentModel> addComment(postId, data) async {
    final response = await client.post('$baseUrl/posts/$postId/comments', data: data);
    if(response.statusCode == 200) {
      return CommentModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<CommentModel> editComment(data, commentId) async {
    final response = await client.put('$baseUrl/comments/$commentId', data: data);
    if(response.statusCode == 200) {
      return CommentModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> deleteComment(commentId) async {
    final response = await client.delete('$baseUrl/comments/$commentId');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> favoriteComment(commentId) async {
    final response = await client.post('$baseUrl/comments/$commentId/favorite');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> unFavoriteComment(commentId) async {
    final response = await client.delete('$baseUrl/comments/$commentId/un_favorite');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }
}