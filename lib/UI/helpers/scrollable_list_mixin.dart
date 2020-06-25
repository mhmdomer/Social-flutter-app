import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social/bloc/scrollable_list_bloc/scrollable_list_bloc.dart';

mixin ScrollableListMixin {
  final _scrollController = ScrollController();
  ScrollableListBloc bloc;
  final scrollThreshold = 200.0;
  Completer _completer;

  void initScrollableList() {
    _scrollController.addListener(_onScroll);
    _completer = Completer<void>();
  }

  void completeCompleter() {
    _completer?.complete();
    _completer = Completer<void>();
  }

  Future completerFuture() {
    return _completer.future;
  }

  animateScroll() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  ScrollController getScrollController() => _scrollController;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= scrollThreshold) {
      bloc.add(LoadList());
    }
  }
}
