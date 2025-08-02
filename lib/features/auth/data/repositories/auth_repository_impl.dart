import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  ResultFuture<User> login(String email, String password) async {
    try {
      final user = await datasource.login(email, password);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  ResultFuture<User> signup(
    String email,
    String password,
    String userName,
  ) async {
    try {
      final user = await datasource.signup(email, password, userName);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.code));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  VoidResult logout() async {
    try {
      await datasource.logout();
      return const Right(unit);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
