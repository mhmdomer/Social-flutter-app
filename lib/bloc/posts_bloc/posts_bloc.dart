import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/data/api_providers/post_api_provider.dart';
import 'package:rxdart/rxdart.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc({this.provider});
  final PostApiProvider provider;

  Stream<Transition<PostsEvent, PostsState>> transformEvents(
    Stream<PostsEvent> events,
    TransitionFunction<PostsEvent, PostsState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  initToken() async {

  }
  @override
  PostsState get initialState => PostsInitial();

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    final currentState = state;
    print(_hasReachedMax(currentState));
    if(event is LoadPosts && !_hasReachedMax(currentState)) {
      try {
        final data = await provider.getPosts();
        print(data['posts'].length);
        yield PostsLoaded(data: data);
      } catch(e) {
        yield PostsError(error: e);
        print(e);
      }
    }
  }

  bool _hasReachedMax(currentState) {
    return currentState is PostsLoaded && currentState.data['hasMore'] == false;
  }
}
