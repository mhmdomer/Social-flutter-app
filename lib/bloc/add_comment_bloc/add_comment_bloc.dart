import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/data/models/comment.dart';
import 'package:social/data/repositories/comments_repository.dart';

part 'add_comment_event.dart';
part 'add_comment_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  final addCommentRepository = CommentsRepository();

  @override
  AddCommentState get initialState => AddCommentInitial();

  @override
  Stream<AddCommentState> mapEventToState(
    AddCommentEvent event,
  ) async* {
    if (event is AddComment) {
      try {
        CommentModel comment =
            await addCommentRepository.addComment(event.postId, event.comment);
        yield AddCommentSuccess(comment: comment);
      } catch (e) {
        yield AddCommentError(error: e);
      }
    }
  }
}
