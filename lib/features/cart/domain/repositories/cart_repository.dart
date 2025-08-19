import '../entities/cart_product.dart';

import '../../../../core/utils/typedef.dart';

abstract class CartRepository {
  ResultFuture<List<CartProductEntity>> addItemToCart(
    CartProductEntity cartProduct,
  );
  ResultFuture<List<CartProductEntity>> updateItemInCart(
    CartProductEntity cartProduct,
  );
  ResultFuture<List<CartProductEntity>> removeItemFromCart(int productId);
  ResultFuture<void> clearCart();
  ResultFuture<List<CartProductEntity>> fetchCartItems();
}
