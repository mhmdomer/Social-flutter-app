import 'secret.dart';

const baseUrl = serverUrl;
const postListUrl = '$baseUrl/posts';
const notificationListUrl = '$baseUrl/notifications';

String getCommentUrl({int postId}) {
  return '$postListUrl/$postId/comments';
}

String getUserPostsUrl({int userId}) {
  return '$baseUrl/users/$userId/posts';
}
