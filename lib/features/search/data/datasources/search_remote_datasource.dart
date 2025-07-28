import '../models/product.dart';

abstract class SearchRemoteDataSource {
  Future<List<Product>> search(String query);
}
