import 'package:dio/dio.dart';
import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/models/notification.dart';

class NotificationApiProvider {
  final _client = Dio();

  Future<List<NotificationModel>> getNotifications() async {
    final response = await _client.get('$baseUrl/notifications');
    if(response.statusCode == 200) {
      return NotificationModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> markAllAsRead() async {
    final response = await _client.post('$baseUrl/notifications/markAsRead');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }
}