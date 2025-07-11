import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  ResultFuture<UserEntity> signup(
    String email,
    String password,
    String userName,
  );
  ResultFuture<UserEntity> login(String email, String password);
  VoidResult logout();
}
