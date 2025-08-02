import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';
import '../models/product.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource datasource;

  SearchRepositoryImpl({required this.datasource});

  @override
  ResultFuture<List<Product>> search(String query) async {
    try {
      final products = await datasource.search(query);
      return Right(products);
    } catch (e) {
      return Left(ApiFailure(e.toString(), 'unknown'));
    }
  }
}
