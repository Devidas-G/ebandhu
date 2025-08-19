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

class CartItemAlreadyExists extends CartState {
  final ProductEntity product;

  const CartItemAlreadyExists(this.product);

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
  final Set<int> loadingProductIds;

  const CartLoaded(this.cartProducts, {this.loadingProductIds = const {}});

  @override
  List<Object> get props => [cartProducts, loadingProductIds];

  CartLoaded copyWith({
    List<CartProductEntity>? cartProducts,
    Set<int>? loadingProductIds,
  }) {
    return CartLoaded(
      cartProducts ?? this.cartProducts,
      loadingProductIds: loadingProductIds ?? this.loadingProductIds,
    );
  }
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
