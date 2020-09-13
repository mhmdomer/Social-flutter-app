part of 'add_comment_bloc.dart';

@immutable
abstract class AddCommentState {}

class AddCommentInitial extends AddCommentState {}

class AddCommentLoading extends AddCommentState {}

class AddCommentError extends AddCommentState {
  AddCommentError({@required this.error});
  final error;
}

class AddCommentSuccess extends AddCommentState {
  AddCommentSuccess({@required this.comment});
  final CommentModel comment;
}
