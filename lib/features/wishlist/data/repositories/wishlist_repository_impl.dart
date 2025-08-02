import 'package:dartz/dartz.dart';
import 'package:ebandhu/core/errors/failure.dart';
import 'package:ebandhu/core/utils/typedef.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_remote_datasource.dart';
import '../models/product.dart';
import 'package:ebandhu/core/errors/exception.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource dataSource;

  WishlistRepositoryImpl({required this.dataSource});

  @override
  ResultFuture<List<ProductEntity>> addToWishlist(ProductEntity product) async {
    try {
      final model = Product.fromEntity(product);
      final products = await dataSource.addToWishlist(model);
      return Right(products);
    } on WishlistException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure(
          'Unexpected error occurred while adding to wishlist',
          'unknown',
        ),
      );
    }
  }

  @override
  ResultFuture<void> clearWishlist() async {
    try {
      await dataSource.clearWishlist();
      return Right(null);
    } on WishlistException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure(
          'Unexpected error occurred while clearing wishlist',
          'unknown',
        ),
      );
    }
  }

  @override
  ResultFuture<List<ProductEntity>> fetchWishlist() async {
    try {
      final products = await dataSource.fetchWishlist();
      return Right(products);
    } on WishlistException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure(
          'Unexpected error occurred while fetching wishlist',
          'unknown',
        ),
      );
    }
  }

  @override
  ResultFuture<List<ProductEntity>> removeFromWishlist(int productId) async {
    try {
      final products = await dataSource.removeFromWishlist(productId);
      return Right(products);
    } on WishlistException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure(
          'Unexpected error occurred while removing from wishlist',
          'unknown',
        ),
      );
    }
  }
}
