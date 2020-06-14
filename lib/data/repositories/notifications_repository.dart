import 'package:social/data/api_providers/notification_api_provider.dart';
import 'package:social/data/models/notification.dart';

class NotificationsRepository {
  final _provider = NotificationApiProvider();

  Future<List<NotificationModel>> getNotifications() => _provider.getNotifications();

  Future<bool> markAllAsRead() => _provider.markAllAsRead();
}