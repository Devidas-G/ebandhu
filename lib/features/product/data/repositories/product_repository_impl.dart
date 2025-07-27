import 'package:ebandhu/core/common/entity/product.dart';
import 'package:ebandhu/core/utils/typedef.dart';
import 'package:ebandhu/features/product/product.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDatasource datasource;

  ProductRepositoryImpl({required this.datasource});
  @override
  ResultFuture<ProductEntity> fetchProduct() {
    // TODO: implement fetchProduct
    throw UnimplementedError();
  }
}
