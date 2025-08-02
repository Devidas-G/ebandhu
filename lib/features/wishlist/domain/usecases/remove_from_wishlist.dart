import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/wishlist_repository.dart';

class RemoveFromWishlist implements UseCase<List<ProductEntity>, int> {
  final WishlistRepository repository;

  RemoveFromWishlist(this.repository);

  @override
  ResultFuture<List<ProductEntity>> call(int productId) async {
    return await repository.removeFromWishlist(productId);
  }
}
