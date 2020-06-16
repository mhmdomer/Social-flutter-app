part of 'scroll_to_top_bloc.dart';

@immutable
abstract class ScrollToTopEvent {}

class ScrollToTop extends ScrollToTopEvent {
  ScrollToTop({@required this.item}) : assert(item != null);
  final TabItem item;
}
