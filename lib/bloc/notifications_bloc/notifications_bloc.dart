import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social/data/api_providers/notification_api_provider.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({this.provider});
  final NotificationApiProvider provider;

  Stream<Transition<NotificationsEvent, NotificationsState>> transformEvents(
    Stream<NotificationsEvent> events,
    TransitionFunction<NotificationsEvent, NotificationsState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  initToken() async {

  }
  @override
  NotificationsState get initialState => NotificationsInitial();

  @override
  Stream<NotificationsState> mapEventToState(NotificationsEvent event) async* {
    final currentState = state;
    print(_hasReachedMax(currentState));
    if(event is LoadNotifications && !_hasReachedMax(currentState)) {
      try {
        final data = await provider.getNotifications();
        print('');
        yield NotificationsLoaded(data: data);
      } catch(e) {
        yield NotificationsError(error: e);
        print(e);
      }
    }
  }

  bool _hasReachedMax(currentState) {
    return currentState is NotificationsLoaded && currentState.data['hasMore'] == false;
  }
}
