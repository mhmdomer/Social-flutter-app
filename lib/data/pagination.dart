import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pagination {
  Pagination({@required this.url}) {
    client.options.headers['Accept'] = 'application/json';
  }
  bool isFirst = true;
  final String url;
  String nextUrl;
  Dio client = Dio();

  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    client.options.headers['authorization'] = 'Bearer ${prefs.getString('token')}';
    if (hasMore()) {
      try {
        nextUrl = isFirst ? url : nextUrl;
        print('$nextUrl');
        final response = await client.get('$nextUrl');
        if (response.statusCode == 200) {
          final result = response.data;
          final data = result['data']['data'];
          nextUrl = result['next_page_url'];
          print(nextUrl);
          isFirst = false;
          return data;
        }
      } on DioError catch (e) {
        print(e);
      }
    } else {}
  }

  bool hasMore() {
    return isFirst || nextUrl != null;
  }

  reset() => isFirst = true;
  
}
