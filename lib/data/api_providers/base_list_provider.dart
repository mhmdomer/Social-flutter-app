import 'package:flutter/material.dart';
import 'package:social/data/api_providers/base_provider.dart';
import 'package:social/data/pagination.dart';

class BaseListProvider extends BaseProvider {
  BaseListProvider({@required this.paginator, @required this.listFromJson});
  final Paginator paginator;
  final Function listFromJson;

  Future getList() async {
    if (paginator.hasMore()) {
      final list = await paginator.getData();
      return {
        'list': listFromJson(list),
        'hasMore': paginator.hasMore(),
      };
    } else {
      return {'list': [], 'hasMore': false};
    }
  }

  reset() => paginator.reset();
}
