import '../models/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> signup(String email, String password, String userName);
  Future<User> login(String email, String password);
  Future<void> logout();
}
