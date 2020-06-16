part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted({@required this.credentials});
  final credentials;
}
