part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

final class AddProductToWishlistEvent extends WishlistEvent {
  final ProductEntity product;

  const AddProductToWishlistEvent(this.product);

  @override
  List<Object> get props => [product];
}

final class RemoveProductFromWishlistEvent extends WishlistEvent {
  final int productId;

  const RemoveProductFromWishlistEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

final class FetchWishlistEvent extends WishlistEvent {}

final class ClearWishlistEvent extends WishlistEvent {}
