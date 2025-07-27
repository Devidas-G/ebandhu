import 'package:dartz/dartz.dart';
import '../datasources/home_remote_datasource.dart';

import '../../../../core/common/entity/product.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDatasource datasource;

  HomeRepositoryImpl({required this.datasource});
  @override
  ResultFuture<List<ProductEntity>> fetchContent() async {
    try {
      final products = await datasource.fetchContent();
      return Right(products);
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }
}
