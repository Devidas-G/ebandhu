import 'package:equatable/equatable.dart';

import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Login implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;
  Login(this.repository);

  @override
  ResultFuture<UserEntity> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
