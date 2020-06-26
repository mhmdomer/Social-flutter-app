import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc {
  String name, email, imageUrl;
  int id;
  @override
  get initialState => UserInitial();

  @override
  Stream mapEventToState(event) async* {
    if(event is SetUserEvent) {
      this.id = event.id;
      this.name = event.userName;
      this.email = event.email;
      this.imageUrl = event.imageUrl;
    }
  }

}

class UserInitial {}


class SetUserEvent {
  SetUserEvent({@required this.id, @required this.userName, @required this.email, @required this.imageUrl});
  final String userName, email, imageUrl;
  final int id;
}