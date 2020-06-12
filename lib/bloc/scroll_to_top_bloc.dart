import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/screens/home.dart';

part 'scroll_to_top_event.dart';
part 'scroll_to_top_state.dart';

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
