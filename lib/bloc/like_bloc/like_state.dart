part of 'like_bloc.dart';

@immutable
abstract class LikeState {}

class LikeBlocInitial extends LikeState {}

class LikeLoading extends LikeState {}

class LikeError extends LikeState {
  LikeError({@required this.error});
  final error;
}

class LikeSuccess extends LikeState {
  LikeSuccess({@required this.liked});
  final bool liked;
}
