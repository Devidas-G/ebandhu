import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class FetchProduct implements UseCase<ProductEntity, int> {
  final ProductRepository repository;

  FetchProduct(this.repository);
  @override
  ResultFuture<ProductEntity> call(int productId) async {
    return await repository.fetchProduct(productId);
  }
}
