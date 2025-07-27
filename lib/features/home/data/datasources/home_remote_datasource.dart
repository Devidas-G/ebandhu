import '../models/product.dart';

abstract class HomeRemoteDatasource {
  Future<List<Product>> fetchContent();
}
