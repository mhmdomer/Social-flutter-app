import 'package:flutter/material.dart';
import 'package:social/bloc/simple_bloc_delegate.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
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
