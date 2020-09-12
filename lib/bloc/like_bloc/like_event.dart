part of 'like_bloc.dart';

@immutable
abstract class LikeEvent {}

class SubmitLike extends LikeEvent {
  SubmitLike({@required this.type, @required this.id});
  final Type type;
  final int id;
}

class SubmitDislike extends LikeEvent {
  SubmitDislike({@required this.type, @required this.id});
  final Type type;
  final int id;
}
