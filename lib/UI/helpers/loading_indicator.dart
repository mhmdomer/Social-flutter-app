import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social/UI/constants.dart';

Widget getLoadingIndicator() {
  return SpinKitFadingCircle(color: mediumBlue);
}