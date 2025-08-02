import '../models/product.dart';

abstract class CartRemoteDataSource {
  Future<List<Product>> fetchCartItems();
  Future<List<Product>> addToCart(Product product);
  Future<List<Product>> removeFromCart(int productId);
  Future<void> clearCart();
}
