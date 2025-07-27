import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';

abstract class HomeRepository {
  ResultFuture<List<ProductEntity>> fetchContent();
}
