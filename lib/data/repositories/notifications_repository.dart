import 'package:social/data/api_providers/notification_api_provider.dart';

class NotificationsRepository {
  final _provider = NotificationApiProvider();

  Future<bool> markAllAsRead() => _provider.markAllAsRead();
}