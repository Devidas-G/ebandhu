import '../models/product.dart';

abstract class ProductRemoteDatasource {
  Future<Product> fetchProduct(int productId);
  Future<bool> isProductFavorited(int productId);
}
