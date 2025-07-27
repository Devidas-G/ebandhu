import 'package:dartz/dartz.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  ResultFuture<UserEntity> login(String email, String password) async {
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
  ResultFuture<UserEntity> signup(
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
