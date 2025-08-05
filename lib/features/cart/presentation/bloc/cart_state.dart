part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class ProductAddedToCart extends CartState {
  final ProductEntity product;

  const ProductAddedToCart(this.product);

  @override
  List<Object> get props => [product];
}

final class ProductRemovedFromCart extends CartState {
  final ProductEntity product;

  const ProductRemovedFromCart(this.product);

  @override
  List<Object> get props => [product];
}

final class CartLoaded extends CartState {
  final List<CartProductEntity> cartProducts;

  const CartLoaded(this.cartProducts);

  @override
  List<Object> get props => [cartProducts];
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  List<Object> get props => [message];
}
