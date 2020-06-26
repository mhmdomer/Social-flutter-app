import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/UI/constants.dart';
import 'package:social/UI/screens/splash.dart';
import 'package:social/bloc/scroll_to_top_bloc.dart';
import 'package:social/bloc/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ScrollToTopBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: mediumBlue,
          accentColor: cornflowerBlue,
          backgroundColor: greyBlue,
          cardColor: cornflowerBlue,
          buttonColor: cornflowerBlue,
          fontFamily: 'Mont'
        ),
        home: SplashScreen(),
      ),
    ),
  );
}
