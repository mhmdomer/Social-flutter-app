import 'package:flutter/material.dart';
import 'package:social/constants.dart';
import 'package:social/screens/welcome.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: mediumBlue,
        accentColor: cornflowerBlue,
        backgroundColor: grayBlue,
        cardColor: cornflowerBlue,
        buttonColor: cornflowerBlue,
      ),
      home: Welcome(),
    ),
  );
}
