import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/data/repositories/comments_repository.dart';
import 'package:social/data/repositories/posts_repository.dart';

part 'like_event.dart';
part 'like_state.dart';

enum Type { post, comment }

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final postsRepository = PostsRepository();
  final commentsRepository = CommentsRepository();

  @override
  LikeState get initialState => LikeBlocInitial();

  @override
  Stream<LikeState> mapEventToState(
    LikeEvent event,
  ) async* {
    if (event is SubmitLike) {
      yield* handleSubmitLikeEvent(event);
    } else if (event is SubmitDislike) {
      yield* handleSubmitDislikeEvent(event);
    }
  }

  Stream<LikeState> handleSubmitLikeEvent(SubmitLike event) async* {
    yield LikeLoading();
    try {
      if (event.type == Type.post) {
        await postsRepository.favoritePost(event.id);
      } else {
        await commentsRepository.favoriteComment(event.id);
      }
      yield LikeSuccess(liked: true);
    } catch (e) {
      yield LikeError(error: e);
    }
  }

  Stream<LikeState> handleSubmitDislikeEvent(SubmitDislike event) async* {
    yield LikeLoading();
    try {
      if (event.type == Type.post) {
        await postsRepository.unFavoritePost(event.id);
      } else {
        await commentsRepository.unFavoriteComment(event.id);
      }
      yield LikeSuccess(liked: false);
    } catch (e) {
      print(e);
      yield LikeError(error: e);
    }
  }
}
