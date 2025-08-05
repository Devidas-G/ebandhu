part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class AddProductToCartEvent extends CartEvent {
  final ProductEntity product;
  final int quantity;

  const AddProductToCartEvent(this.product, this.quantity);

  @override
  List<Object> get props => [product, quantity];
}

final class RemoveProductFromCartEvent extends CartEvent {
  final ProductEntity product;

  const RemoveProductFromCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

final class FetchCartEvent extends CartEvent {}

final class ClearCartEvent extends CartEvent {}
