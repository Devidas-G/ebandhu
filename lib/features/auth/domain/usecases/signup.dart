import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Signup implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;
  Signup(this.repository);

  @override
  ResultFuture<UserEntity> call(SignUpParams params) async {
    return await repository.signup(
      params.email,
      params.password,
      params.userName,
    );
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String userName;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.userName,
  });

  @override
  List<Object?> get props => [email, password, userName];
}
