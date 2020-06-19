part of 'scrollable_list_bloc.dart';

@immutable
abstract class ScrollableListEvent {}

class LoadList extends ScrollableListEvent {}

class RefreshList extends ScrollableListEvent {}
