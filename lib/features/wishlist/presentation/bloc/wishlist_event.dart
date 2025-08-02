part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

final class AddItemEvent extends WishlistEvent {
  final ProductEntity product;

  const AddItemEvent(this.product);

  @override
  List<Object> get props => [product];
}

final class RemoveItemEvent extends WishlistEvent {
  final int productId;

  const RemoveItemEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

final class FetchWishlistEvent extends WishlistEvent {}

final class ClearWishlistEvent extends WishlistEvent {}
