part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  RegisterError({@required this.error});
  final error;
}

class RegisterSuccess extends RegisterState {}
