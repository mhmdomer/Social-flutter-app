part of 'add_comment_bloc.dart';

@immutable
abstract class AddCommentEvent {}

class AddComment extends AddCommentEvent {
  AddComment({@required this.postId, @required this.comment});
  final int postId;
  final String comment;
}
