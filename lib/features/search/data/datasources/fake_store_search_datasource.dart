import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'search_remote_datasource.dart';

class FakeStoreSearchDatasource implements SearchRemoteDataSource {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  @override
  Future<List<Product>> search(String query) async {
    // If API supports search, you can modify the URL or add query params here
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch products: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
