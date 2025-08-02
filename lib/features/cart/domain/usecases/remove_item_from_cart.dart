import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/cart_repository.dart';

class RemoveItemFromCart implements UseCase<List<ProductEntity>, int> {
  final CartRepository repository;

  RemoveItemFromCart(this.repository);

  @override
  ResultFuture<List<ProductEntity>> call(int productId) async {
    return await repository.removeItemFromCart(productId);
  }
}
