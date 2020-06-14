import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollAnimator {
  ScrollAnimator({@required this.ticker}) : assert(ticker != null);
  AnimationController _hide;
  final TickerProviderStateMixin ticker;

  void init() {
    _hide = AnimationController(vsync: ticker, duration: kThemeAnimationDuration);
  }

  AnimationController getAnimator() {
    return _hide;
  }

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            _hide.forward();
            break;
          case ScrollDirection.reverse:
            _hide.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }
}
