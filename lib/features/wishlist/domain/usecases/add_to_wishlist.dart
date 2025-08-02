import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/wishlist_repository.dart';

class AddToWishlist implements UseCase<List<ProductEntity>, ProductEntity> {
  final WishlistRepository repository;

  AddToWishlist(this.repository);

  @override
  ResultFuture<List<ProductEntity>> call(ProductEntity item) async {
    return await repository.addToWishlist(item);
  }
}
