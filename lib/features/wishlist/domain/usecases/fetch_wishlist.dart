import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/wishlist_repository.dart';

class FetchWishlist implements UseCase<List<ProductEntity>, NoParams> {
  final WishlistRepository repository;

  FetchWishlist(this.repository);

  @override
  ResultFuture<List<ProductEntity>> call(NoParams params) async {
    return await repository.fetchWishlist();
  }
}
