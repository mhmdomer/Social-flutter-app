import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social/data/api_providers/base_list_provider.dart';

part 'scrollable_list_event.dart';
part 'scrollable_list_state.dart';

class ScrollableListBloc
    extends Bloc<ScrollableListEvent, ScrollableListState> {
  ScrollableListBloc({this.provider});
  final BaseListProvider provider;

  Stream<Transition<ScrollableListEvent, ScrollableListState>> transformEvents(
    Stream<ScrollableListEvent> events,
    TransitionFunction<ScrollableListEvent, ScrollableListState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  ScrollableListState get initialState => ScrollableListInitial();

  @override
  Stream<ScrollableListState> mapEventToState(
      ScrollableListEvent event) async* {
    final currentState = state;
    print(_hasReachedMax(currentState));
    if (event is LoadList && !_hasReachedMax(currentState)) {
      try {
        var list = [];
        if (currentState is ListLoaded) {
          list = currentState.data['list'];
        }
        final data = await provider.getList();
        data['list'] = list + data['list'];
        yield ListLoaded(data: data);
      } catch (e) {
        yield ListError(error: e);
        print(e);
      }
    }
    if (event is RefreshList) {
      provider.reset();
      if (currentState is ListLoaded) {
        currentState.data['hasMore'] = true;
        currentState.data['list'] = [];
      }
      add(LoadList());
    }
  }

  bool _hasReachedMax(currentState) {
    return currentState is ListLoaded && currentState.data['hasMore'] == false;
  }
}
