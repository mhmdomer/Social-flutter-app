import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/data/repositories/follow_repository.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final repository = FollowRepository();
  @override
  FollowState get initialState => FollowInitial();

  @override
  Stream<FollowState> mapEventToState(FollowEvent event) async* {
    if (event is FollowUser || event is UnFollowUser) {
      bool result = false;
      try {
        yield FollowLoading();
        if (event is FollowUser) {
          result = await repository.follow(event.userId);
          if (result == true) {
            yield FollowSuccess(isFollowing: true);
          } else {
            yield FollowError(error: 'Sorry, something went wrong!');
          }
        }
        if (event is UnFollowUser) {
          result = await repository.unFollow(event.userId);
          if (result == true) {
            yield FollowSuccess(isFollowing: false);
          } else {
            yield FollowError(error: 'Sorry!, something went wrong!');
          }
        }
      } catch (e) {
        yield FollowError(error: e.toString());
      }
    }
  }
}
