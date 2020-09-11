part of 'follow_bloc.dart';

@immutable
abstract class FollowEvent {}

class FollowUser extends FollowEvent {
  FollowUser({@required this.userId});
  final int userId;
}

class UnFollowUser extends FollowEvent {
  UnFollowUser({@required this.userId});
  final int userId;
}
