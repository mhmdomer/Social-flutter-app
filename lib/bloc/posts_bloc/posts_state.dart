part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  PostsLoaded({this.data});
  final data;
}

class PostsError extends PostsState {
  PostsError({this.error});
  final error;
}
