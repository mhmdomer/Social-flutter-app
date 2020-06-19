import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/UI/screens/home.dart';

class ScrollToTopBloc extends Bloc<ScrollToTopEvent, ScrollToTopState> {
  @override
  ScrollToTopState get initialState => ScrollToTopInitial();

  @override
  Stream<ScrollToTopState> mapEventToState(ScrollToTopEvent event) async* {
    if(event is ScrollToTop) {
      yield ScrolledToTop(item: event.item);
    }
  }
}

abstract class ScrollToTopState {}

class ScrollToTopInitial extends ScrollToTopState {}

class ScrolledToTop extends ScrollToTopState {
  ScrolledToTop({@required this.item}) : assert(item != null);
  final TabItem item;
}

@immutable
abstract class ScrollToTopEvent {}

class ScrollToTop extends ScrollToTopEvent {
  ScrollToTop({@required this.item}) : assert(item != null);
  final TabItem item;
}


