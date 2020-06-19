import 'package:social/data/api_providers/api_constants.dart';
import 'package:social/data/api_providers/base_provider.dart';

class NotificationApiProvider extends BaseProvider {

  Future<bool> markAllAsRead() async {
    final response = await client.post('$baseUrl/notifications/mark_read');
    if(response.statusCode == 200) {
      return true;
    } else {
      throw response.data['message'];
    }
  }
}