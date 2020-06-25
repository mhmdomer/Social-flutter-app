import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/data/models/user.dart';
import 'package:social/data/repositories/users_repository.dart';

class ProfileBloc extends Bloc {
  final repository = UsersRepository();
  @override
  get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(event) async* {
    if(event is LoadProfile) {
      try {
        final user = await repository.getUser(event.id);
        yield ProfileLoaded(user: user);
      } catch(e) {
        print(e);
        yield ProfileError(error: e);
      }
    }
  }

}

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  ProfileLoaded({this.user});
  final UserModel user;
}

class ProfileError extends ProfileState {
  ProfileError({@required this.error});
  final String error;
}

class LoadProfile {
  LoadProfile({this.id});
  final id;
}