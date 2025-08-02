abstract class WishlistRemoteDataSource {
  Future<void> addToWishlist(String productId);
  Future<void> removeFromWishlist(String productId);
  Future<List<String>> getWishlist();
  Future<void> clearWishlist();
}
