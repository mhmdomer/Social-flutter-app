import 'package:social/data/api_providers/post_api_provider.dart';
import 'package:social/data/models/post.dart';

class PostsRepository {
  final _provider = PostApiProvider();

  Future<PostModel> addPost(data) => _provider.createPost(data);

  Future<PostModel> editPost(postId, data) => _provider.editPost(postId, data);

  Future<bool> deletePost(postId) => _provider.deletePost(postId);

  Future<bool> favoritePost(postId) => _provider.favoritePost(postId);

  Future<bool> unFavoritePost(postId) => _provider.unFavoritePost(postId);
}