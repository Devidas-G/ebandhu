import 'package:equatable/equatable.dart';

import 'product.dart';

class CartProductEntity extends Equatable {
  final ProductEntity product;
  final int quantity;

  const CartProductEntity({required this.product, required this.quantity});

  @override
  List<Object?> get props => [product, quantity];
}
