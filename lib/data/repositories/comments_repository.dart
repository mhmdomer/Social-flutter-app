import 'package:social/data/api_providers/comment_api_provider.dart';
import 'package:social/data/models/comment.dart';

class CommentsRepository {
  final _provider = CommentApiProvider();

  Future<List<CommentModel>> getComments(postId) => _provider.getComments(postId);

  Future<CommentModel> addComment(postId, data) => _provider.addComment(postId, data);

  Future<CommentModel> editComment(commentId, data) => _provider.editComment(commentId, data);

  Future<bool> deleteComment(commentId) => _provider.deleteComment(commentId);

  Future<bool> favoriteComment(commentId) => _provider.favoriteComment(commentId);

  Future<bool> unFavoriteComment(commentId) => _provider.unFavoriteComment(commentId);
}