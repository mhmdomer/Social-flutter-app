import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationAnimations {
  AuthenticationAnimations({@required this.mixin, this.onTextSizeChanged})
      : assert(
          mixin != null && onTextSizeChanged != null,
        );

  Function onTextSizeChanged;
  TickerProviderStateMixin mixin;
  AnimationController textController;
  AnimationController rotationController;
  int counter = 0;

  void init() {
    textController = AnimationController(
        vsync: mixin,
        duration: Duration(microseconds: 800),
        lowerBound: 30,
        upperBound: 40);
    textController.forward();
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: mixin);
    rotationController.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        if (counter++ > 1) {
          rotationController.stop();
        } else {
          rotationController.reset();
          rotationController.forward();
        }
      }
    });
    textController.addListener(() {
      onTextSizeChanged();
      print(textController.value);
    });
    rotationController.forward();
  }
}
