const baseUrl = 'http://phplaravel-430765-1350704.cloudwaysapps.com/api/v1';
const postListUrl = '$baseUrl/posts';
const notificationListUrl = '$baseUrl/notifications';

String getCommentUrl({int postId}) {
  return '$postListUrl/$postId/comments';
}

String getUserPostsUrl({int userId}) {
  return '$baseUrl/users/$userId/posts';
}