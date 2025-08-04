import 'package:dartz/dartz.dart';
import 'package:ebandhu/core/common/entity/product.dart';
import 'package:ebandhu/core/utils/typedef.dart';
import 'package:ebandhu/features/product/product.dart';

import '../../../../core/errors/failure.dart';
import '../models/product.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDatasource datasource;

  ProductRepositoryImpl({required this.datasource});
  @override
  ResultFuture<ProductEntity> fetchProduct(int productId) async {
    try {
      final product = await datasource.fetchProduct(productId);
      return Right(product);
    } catch (e) {
      return Left(ApiFailure(e.toString(), 'unknown'));
    }
  }

  @override
  ResultFuture<bool> isProductFavorited(int productId) async {
    try {
      final isFavorited = await datasource.isProductFavorited(productId);
      return Right(isFavorited);
    } catch (e) {
      return Left(ApiFailure(e.toString(), 'unknown'));
    }
  }
}
