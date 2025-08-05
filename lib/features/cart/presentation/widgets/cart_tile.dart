import 'package:flutter/material.dart';

import '../../domain/entities/cart_product.dart';
import '../../domain/entities/product.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.cartProduct,
    required this.onRemove,
  });
  final CartProductEntity cartProduct;
  final ValueChanged<CartProductEntity> onRemove;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartProduct.product.title),
      subtitle: Text("Price: \$${cartProduct.product.price}"),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle_outline),
        onPressed: () => onRemove(cartProduct),
      ),
    );
  }
}
