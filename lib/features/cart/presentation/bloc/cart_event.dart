part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class AddItemEvent extends CartEvent {
  final ProductEntity item;

  const AddItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

final class RemoveItemEvent extends CartEvent {
  final int productId;

  const RemoveItemEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

final class FetchCartEvent extends CartEvent {}

final class ClearCartEvent extends CartEvent {}
