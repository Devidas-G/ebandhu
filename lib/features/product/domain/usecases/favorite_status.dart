import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/product_repository.dart';

class FavoriteStatus implements UseCase<bool, int> {
  final ProductRepository repository;

  FavoriteStatus(this.repository);
  @override
  ResultFuture<bool> call(int productId) async {
    return await repository.isProductFavorited(productId);
  }
}
