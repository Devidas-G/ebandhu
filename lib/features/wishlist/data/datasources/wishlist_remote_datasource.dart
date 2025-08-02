import '../models/product.dart';

abstract class WishlistRemoteDataSource {
  Future<List<Product>> addToWishlist(Product product);
  Future<List<Product>> removeFromWishlist(int productId);
  Future<List<Product>> fetchWishlist();
  Future<void> clearWishlist();
}
