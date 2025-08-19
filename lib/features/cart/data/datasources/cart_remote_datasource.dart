import '../models/cart_product.dart';

abstract class CartRemoteDataSource {
  Future<List<CartProduct>> fetchCartItems();
  Future<List<CartProduct>> addToCart(CartProduct product);
  Future<List<CartProduct>> updateItemInCart(CartProduct product);
  Future<List<CartProduct>> removeFromCart(int productId);
  Future<void> clearCart();
}
