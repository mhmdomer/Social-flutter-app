const baseUrl = 'https://vampiresocial.herokuapp.com/api/v1';
const postListUrl = '$baseUrl/posts';
const notificationListUrl = '$baseUrl/notifications';
var test_var = '';

String getCommentUrl({int postId}) {
  return '$postListUrl/$postId/comments';
}

String getUserPostsUrl({int userId}) {
  return '$baseUrl/users/$userId/posts';
}