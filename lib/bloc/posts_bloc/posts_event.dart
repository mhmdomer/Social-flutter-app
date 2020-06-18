part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class LoadPosts extends PostsEvent {}
