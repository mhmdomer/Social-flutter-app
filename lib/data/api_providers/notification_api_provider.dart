import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_provider.dart';
import 'package:social/data/models/notification.dart';
import 'package:social/data/pagination.dart';

class NotificationApiProvider extends BaseProvider {
final Pagination notificationsPaginator =
      Pagination(url: '$baseUrl/notifications');

  reset() => notificationsPaginator.reset();
      
  Future getNotifications() async {
    if (notificationsPaginator.hasMore()) {
      final notifications = await notificationsPaginator.getData();
      return {
        'notifications' : NotificationModel.listFromJson(notifications),
        'hasMore' : notificationsPaginator.hasMore(),
      };
    } else {
      return {
        'notifications' : [],
        'hasMore' : false
      };
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