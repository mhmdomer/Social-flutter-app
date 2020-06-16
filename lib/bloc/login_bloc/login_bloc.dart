import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/data/repositories/users_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UsersRepository repository = UsersRepository();
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield LoginLoading();
      try {
        await repository.loginUser(event.credentials);
        yield LoginSuccess();
      } catch (e) {
        yield* showError(e);
      }
    }
  }

  Stream<LoginState> showError(e) async* {
    final errors = e['errors'];
    if (errors != null) {
      if (errors['email'] != null) {
        yield LoginError(error: errors['email'][0]);
      } else if (errors['password'] != null) {
        yield LoginError(error: errors['password'][0]);
      }
    } else if (e['message'] != null) {
      yield LoginError(error: e['message']);
    } else {
      yield LoginError(error: 'Sorry, an error occurred');
    }
  }
}
