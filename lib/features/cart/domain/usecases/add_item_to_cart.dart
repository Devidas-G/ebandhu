import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/cart_repository.dart';

class AddItemToCart implements UseCase<List<ProductEntity>, ProductEntity> {
  final CartRepository repository;

  AddItemToCart(this.repository);

  @override
  ResultFuture<List<ProductEntity>> call(ProductEntity item) async {
    return await repository.addItemToCart(item);
  }
}
