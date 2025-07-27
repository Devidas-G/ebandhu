import 'dart:convert';

import 'package:ebandhu/core/common/model/product.dart';
import 'package:http/http.dart' as http;

import 'product_remote_datasource.dart';

class FakeStoreProductDatasource extends ProductRemoteDatasource {
  @override
  Future<Product> fetchProduct(int productId) async {
    final url = Uri.parse('https://fakestoreapi.com/products/$productId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Product.fromJson(data);
      } else {
        throw Exception(
          'Failed to fetch product: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }
}
