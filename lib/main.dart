import 'package:flutter/material.dart';
import 'package:social/constants.dart';
import 'package:social/screens/home.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: mediumBlue,
        accentColor: cornflowerBlue,
        backgroundColor: greyBlue,
        cardColor: cornflowerBlue,
        buttonColor: cornflowerBlue,
      ),
      home: HomePage(),
    ),
  );
}
