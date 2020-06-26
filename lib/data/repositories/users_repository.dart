import 'package:social/data/api_providers/user_api_provider.dart';
import 'package:social/data/models/user.dart';

class UsersRepository {
  final _provider = UserApiProvider();

  Future<UserModel> registerUser(credentials) async => await _provider.createUser(credentials);

  Future<UserModel> loginUser(credentials) async => await _provider.loginUser(credentials);

  Future<UserModel> getUser(id) async => await _provider.getUser(id);
  
}