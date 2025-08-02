import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/cart_repository.dart';

class ClearCart implements UseCase<void, NoParams> {
  final CartRepository repository;

  ClearCart(this.repository);

  @override
  ResultFuture<void> call(NoParams params) async {
    return await repository.clearCart();
  }
}
