import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_provider.dart';
import 'package:social/data/models/post.dart';
import 'package:social/data/pagination.dart';

class PostApiProvider extends BaseProvider {
  final Pagination postsPaginator =
      Pagination(token: BaseProvider.token, url: '$baseUrl/posts');

  Future getPosts() async {
    if (postsPaginator.hasMore()) {
      final posts = await postsPaginator.getData();
      return {
        'posts' : PostModel.listFromJson(posts),
        'hasMore' : postsPaginator.hasMore(),
      };
    } else {
      return {
        'posts' : [],
        'hasMore' : false
      };
    }
  }

  Future<PostModel> getPost(id) async {
    final response = await client.get('$baseUrl/posts/$id');
    if (response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<PostModel> createPost(data) async {
    final response = await client.post('$baseUrl/posts', data: data);
    if (response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<PostModel> editPost(id, data) async {
    final response = await client.put('$baseUrl/posts/$id', data: data);
    if (response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> deletePost(id) async {
    final response = await client.delete('$baseUrl/posts/$id');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> favoritePost(id) async {
    final response = await client.post('$baseUrl/posts/$id/favorite');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> unFavoritePost(id) async {
    final response = await client.delete('$baseUrl/posts/$id/un_favorite');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }
}
