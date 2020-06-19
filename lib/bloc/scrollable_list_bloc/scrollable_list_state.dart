part of 'scrollable_list_bloc.dart';

@immutable
abstract class ScrollableListState {}

class ScrollableListInitial extends ScrollableListState {}

class ListLoading extends ScrollableListState {}

class ListLoaded extends ScrollableListState {
  ListLoaded({this.data});
  final data;
}

class ListError extends ScrollableListState {
  ListError({this.error});
  final error;
}
