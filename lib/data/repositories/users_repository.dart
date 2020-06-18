import 'package:social/data/api_providers/user_api_provider.dart';
import 'package:social/data/models/user.dart';

class UsersRepository {
  final _provider = UserApiProvider();

  registerUser(credentials) => _provider.createUser(credentials);

  loginUser(credentials) => _provider.loginUser(credentials);

  Future<UserModel> getUser(id) => _provider.getUser(id);
  
}