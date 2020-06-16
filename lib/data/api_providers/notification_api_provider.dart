import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_provider.dart';
import 'package:social/data/models/notification.dart';

class NotificationApiProvider extends BaseProvider {

  Future<List<NotificationModel>> getNotifications() async {
    final response = await client.get('$baseUrl/notifications');
    if(response.statusCode == 200) {
      return NotificationModel.fromJson(response.data);
    } else {
      throw response.data['message'];
    }
  }

  Future<bool> markAllAsRead() async {
    final response = await client.post('$baseUrl/notifications/mark_read');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }
}