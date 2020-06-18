import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/data/repositories/users_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UsersRepository repository = UsersRepository();
  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterSubmitted) {
      yield RegisterLoading();
      try {
        await repository.registerUser(event.credentials);
        yield RegisterSuccess();
      } catch (e) {
        yield* showError(e);
      }
    }
  }

  Stream<RegisterState> showError(e) async* {
    if(e is String) {
      yield RegisterError(error: e);
      return;
    }
    if (e['email'] != null) {
      yield RegisterError(error: e['email'][0]);
    } else if (e['name'] != null) {
      yield RegisterError(error: e['name'][0]);
    } else if (e['password'] != null) {
      yield RegisterError(error: e['password'][0]);
    } else {
      yield RegisterError(error: 'Sorry, an error occurred');
    }
  }
}
