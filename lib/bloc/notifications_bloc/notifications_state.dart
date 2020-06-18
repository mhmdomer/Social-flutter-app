part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  NotificationsLoaded({this.data});
  final data;
}

class NotificationsError extends NotificationsState {
  NotificationsError({this.error});
  final error;
}
