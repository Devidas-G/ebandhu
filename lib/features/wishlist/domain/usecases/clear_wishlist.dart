import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/wishlist_repository.dart';

class ClearWishlist implements UseCase<void, NoParams> {
  final WishlistRepository repository;

  ClearWishlist(this.repository);

  @override
  ResultFuture<void> call(NoParams params) async {
    return await repository.clearWishlist();
  }
}
