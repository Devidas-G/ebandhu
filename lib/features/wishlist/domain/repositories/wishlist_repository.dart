import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';

abstract class WishlistRepository {
  ResultFuture<List<ProductEntity>> addToWishlist(ProductEntity product);
  ResultFuture<List<ProductEntity>> removeFromWishlist(int productId);
  ResultFuture<List<ProductEntity>> fetchWishlist();
  ResultFuture<void> clearWishlist();
}
