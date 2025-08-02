import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exception.dart';
import '../models/user.dart' as core;
import 'auth_remote_datasource.dart';

class FirebaseAuthDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;

  FirebaseAuthDataSourceImpl({required this.auth});

  @override
  Future<core.User> signup(
    String email,
    String password,
    String userName,
  ) async {
    try {
      final UserCredential credential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user == null) {
        throw AuthException(
          message: 'SignUp failed: No user created',
          code: 'no-user',
        );
      }
      await credential.user?.updateDisplayName(userName);
      await credential.user?.reload();
      return core.User(
        id: credential.user!.uid,
        name: credential.user!.displayName ?? "Anonymous",
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message, code: e.code);
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  @override
  Future<core.User> login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw AuthException(
          message: 'Login failed: No user found',
          code: 'no-user',
        );
      }
      return core.User(
        id: credential.user!.uid,
        name: credential.user!.displayName ?? "Anonymous",
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Unknown error', code: e.code);
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }
}
