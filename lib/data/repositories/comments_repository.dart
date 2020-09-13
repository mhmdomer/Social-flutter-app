import 'package:social/data/api_providers/comment_api_provider.dart';
import 'package:social/data/models/comment.dart';

class CommentsRepository {
  final _provider = CommentApiProvider();

  Future<CommentModel> addComment(postId, comment) =>
      _provider.addComment(postId, comment);

  Future<CommentModel> editComment(commentId, data) =>
      _provider.editComment(commentId, data);

  Future<bool> deleteComment(commentId) => _provider.deleteComment(commentId);

  Future<bool> favoriteComment(commentId) =>
      _provider.favoriteComment(commentId);

  Future<bool> unFavoriteComment(commentId) =>
      _provider.unFavoriteComment(commentId);
}
