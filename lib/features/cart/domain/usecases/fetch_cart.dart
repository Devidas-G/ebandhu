import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/cart_repository.dart';

class FetchCart implements UseCase<List<ProductEntity>, NoParams> {
  final CartRepository repository;

  FetchCart(this.repository);

  @override
  ResultFuture<List<ProductEntity>> call(NoParams params) async {
    return await repository.fetchCartItems();
  }
}
