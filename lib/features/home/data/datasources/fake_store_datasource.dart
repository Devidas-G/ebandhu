import 'dart:convert';

import 'package:ebandhu/features/home/data/datasources/home_remote_datasource.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class FakeStoreDatasource extends HomeRemoteDatasource {
  @override
  Future<List<Product>> fetchContent() async {
    final url = Uri.parse('https://fakestoreapi.com/products');
    try {
      final response = await http.get(url);
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
