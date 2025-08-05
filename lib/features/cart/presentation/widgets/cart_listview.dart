import 'package:flutter/material.dart';

import '../../domain/entities/cart_product.dart';
import 'cart_tile.dart';

class CartListview extends StatelessWidget {
  const CartListview({
    super.key,
    required this.cartProducts,
    required this.onRemove,
  });
  final List<CartProductEntity> cartProducts;
  final ValueChanged<CartProductEntity> onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartProducts.length,
      itemBuilder: (context, index) {
        final product = cartProducts[index];
        return CartTile(cartProduct: product, onRemove: onRemove);
      },
    );
  }
}
