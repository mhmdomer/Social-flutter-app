part of 'follow_bloc.dart';

@immutable
abstract class FollowState {}

class FollowInitial extends FollowState {}

class FollowLoading extends FollowState {}

class FollowSuccess extends FollowState {
  FollowSuccess({@required this.isFollowing});
  final bool isFollowing;
}

class FollowError extends FollowState {
  FollowError({@required this.error});
  final String error;
}
