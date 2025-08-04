part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductEvent extends ProductEvent {
  final int productId;

  const FetchProductEvent({required this.productId});
  @override
  List<Object> get props => [productId];
}

final class CheckFavoriteStatusEvent extends ProductEvent {
  final int productId;

  const CheckFavoriteStatusEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
