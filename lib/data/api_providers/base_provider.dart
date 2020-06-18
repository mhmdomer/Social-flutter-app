import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseProvider {
  final client = Dio();
  static String token;
  BaseProvider() {
    initClient();
  }

  initClient() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    client.options.headers['Accept'] = 'application/json';
    client.options.headers['authorization'] = 'Bearer $token';
  }
}
