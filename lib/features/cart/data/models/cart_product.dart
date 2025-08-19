import '../../domain/entities/cart_product.dart';
import 'product.dart';

class CartProduct extends CartProductEntity {
  const CartProduct({required super.product, required super.quantity});

  factory CartProduct.fromEntity(CartProductEntity cartProduct) {
    return CartProduct(
      product: cartProduct.product,
      quantity: cartProduct.quantity,
    );
  }
  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'product': (product as Product).toJson(), 'quantity': quantity};
  }
}
