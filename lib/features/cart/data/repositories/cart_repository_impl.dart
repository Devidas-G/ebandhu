import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/cart_product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_product.dart';
import '../datasources/cart_remote_datasource.dart';
import '../../../../core/errors/exception.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource datasource;
  CartRepositoryImpl({required this.datasource});

  @override
  ResultFuture<List<CartProduct>> addItemToCart(
    CartProductEntity cartProduct,
  ) async {
    try {
      final cartModel = CartProduct.fromEntity(cartProduct);
      final products = await datasource.addToCart(cartModel);
      return Right(products);
    } on CartException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure('Unexpected error occurred while adding to cart', 'unknown'),
      );
    }
  }

  @override
  ResultFuture<List<CartProduct>> removeItemFromCart(int productId) async {
    try {
      final products = await datasource.removeFromCart(productId);
      return Right(products);
    } on CartException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure(
          'Unexpected error occurred while removing from cart',
          'unknown',
        ),
      );
    }
  }

  @override
  ResultFuture<void> clearCart() async {
    try {
      await datasource.clearCart();
      return Right(null);
    } on CartException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure('Unexpected error occurred while clearing cart', 'unknown'),
      );
    }
  }

  @override
  ResultFuture<List<CartProduct>> fetchCartItems() async {
    try {
      final products = await datasource.fetchCartItems();
      return Right(products);
    } on CartException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure(
          'Unexpected error occurred while fetching cart items',
          'unknown',
        ),
      );
    }
  }

  @override
  ResultFuture<List<CartProductEntity>> updateItemInCart(
    CartProductEntity cartProduct,
  ) async {
    try {
      final cartModel = CartProduct.fromEntity(cartProduct);
      final products = await datasource.updateItemInCart(cartModel);
      return Right(products);
    } on CartException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure(
          'Unexpected error occurred while updating cart item',
          'unknown',
        ),
      );
    }
  }
}
