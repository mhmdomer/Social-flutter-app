part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  LoginError({@required this.error});
  final error;
}

class LoginSuccess extends LoginState {}
