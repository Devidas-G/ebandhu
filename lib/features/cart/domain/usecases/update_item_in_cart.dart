import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/cart_product.dart';
import '../repositories/cart_repository.dart';

class UpdateItemInCart
    implements UseCase<List<CartProductEntity>, CartProductEntity> {
  final CartRepository repository;

  UpdateItemInCart(this.repository);

  @override
  ResultFuture<List<CartProductEntity>> call(CartProductEntity item) async {
    return await repository.updateItemInCart(item);
  }
}
