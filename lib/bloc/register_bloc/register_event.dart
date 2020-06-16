part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  RegisterSubmitted({@required this.credentials});
  final credentials;
}
