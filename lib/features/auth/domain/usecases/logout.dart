import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repository.dart';

class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  VoidResult call() async {
    return await repository.logout();
  }
}
