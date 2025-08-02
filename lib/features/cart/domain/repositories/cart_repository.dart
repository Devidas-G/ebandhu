import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';

abstract class CartRepository {
  ResultFuture<List<ProductEntity>> addItemToCart(ProductEntity product);
  ResultFuture<List<ProductEntity>> removeItemFromCart(int productId);
  ResultFuture<void> clearCart();
  ResultFuture<List<ProductEntity>> fetchCartItems();
}
