part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final ProductEntity product;
  final bool isFavorite;

  const ProductLoaded(this.product, {this.isFavorite = false});
  @override
  List<Object> get props => [product, isFavorite];

  ProductLoaded copyWith({ProductEntity? product, bool? isFavorite}) {
    return ProductLoaded(
      product ?? this.product,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

final class ProductError extends ProductState {
  final String errorMessage;

  const ProductError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
