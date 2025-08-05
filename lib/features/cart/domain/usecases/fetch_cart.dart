import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/cart_product.dart';
import '../repositories/cart_repository.dart';

class FetchCart implements UseCase<List<CartProductEntity>, NoParams> {
  final CartRepository repository;

  FetchCart(this.repository);

  @override
  ResultFuture<List<CartProductEntity>> call(NoParams params) async {
    return await repository.fetchCartItems();
  }
}
