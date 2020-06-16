import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenBloc extends Bloc {
  @override
  get initialState => TokenState(token: '');

  @override
  Stream<TokenState> mapEventToState(event) async* {
    final preferences = await SharedPreferences.getInstance();
    if(event is GetTokenEvent) {
      final token = preferences.getString('token');
      yield TokenState(token: token);
    } else if(event is ClearTokenEvent) {
      preferences.setString('token', '');
      yield TokenState(token: '');
    }
  }

}

class TokenState {
  TokenState({@required this.token});
  final token;
}

abstract class TokenEvent {}

class GetTokenEvent extends TokenEvent {}

class ClearTokenEvent extends TokenEvent {}
