import 'package:social/data/api_providers/follow_api_provider.dart';

class FollowRepository {
  final provider = FollowApiProvider();

  Future<bool> follow(userId) async => await provider.follow(userId);

  Future<bool> unFollow(userId) async => await provider.unFollow(userId);
}