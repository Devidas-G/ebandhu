import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  ResultFuture<ProductEntity> fetchProduct();
}
