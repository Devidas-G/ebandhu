import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/cart_product.dart';
import '../repositories/cart_repository.dart';

class RemoveItemFromCart implements UseCase<List<CartProductEntity>, int> {
  final CartRepository repository;

  RemoveItemFromCart(this.repository);

  @override
  ResultFuture<List<CartProductEntity>> call(int productId) async {
    return await repository.removeItemFromCart(productId);
  }
}
