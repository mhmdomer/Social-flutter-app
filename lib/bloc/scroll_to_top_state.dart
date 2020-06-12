part of 'scroll_to_top_bloc.dart';

@immutable
abstract class ScrollToTopState {}

class ScrollToTopInitial extends ScrollToTopState {}

class ScrolledToTop extends ScrollToTopState {
  ScrolledToTop({@required this.item}) : assert(item != null);
  final TabItem item;
}
