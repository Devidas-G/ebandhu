import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';

abstract class SearchRepository {
  ResultFuture<List<ProductEntity>> search(String query);
}
