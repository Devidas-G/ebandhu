import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/product.dart';
import '../datasources/cart_remote_datasource.dart';
import '../../../../core/errors/exception.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource datasource;
  CartRepositoryImpl({required this.datasource});

  @override
  ResultFuture<List<Product>> addItemToCart(ProductEntity product) async {
    try {
      final model = Product.fromEntity(product);
      final products = await datasource.addToCart(model);
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
  ResultFuture<List<Product>> removeItemFromCart(int productId) async {
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
  ResultFuture<List<Product>> fetchCartItems() async {
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
}
