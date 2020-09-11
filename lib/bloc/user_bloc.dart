import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<SetUserEvent, UserState> {
  String name, email, imageUrl;
  int id;
  @override
  get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(event) async* {
    if(event is SetUserEvent) {
      yield UserFetched(
        id: event.id,
        name: event.userName,
        email: event.email,
        imageUrl: event.imageUrl,
      );
    }
  }

}

abstract class UserState {}
class UserInitial extends UserState {}

class UserFetched extends UserState {
  UserFetched({@required this.id, @required this.name, @required this.email, @required this.imageUrl});
  final int id;
  final String name, email, imageUrl;
}

class SetUserEvent {
  SetUserEvent({@required this.id, @required this.userName, @required this.email, @required this.imageUrl});
  final String userName, email, imageUrl;
  final int id;
}