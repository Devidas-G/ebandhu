import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebandhu/core/common/model/product.dart';
import 'package:http/http.dart' as http;

import 'product_remote_datasource.dart';

class FakeStoreProductDatasource extends ProductRemoteDatasource {
  final FirebaseFirestore firestore;
  final String? userId;
  FakeStoreProductDatasource({required this.firestore, this.userId}) {
    if (userId == null || userId!.isEmpty) {
      throw Exception('User is not authenticated.');
    }
  }

  CollectionReference<Map<String, dynamic>> get _wishlistRef =>
      firestore.collection('users').doc(userId).collection('wishlist');

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

  @override
  Future<bool> isProductFavorited(int productId) async {
    try {
      final docSnapshot = await _wishlistRef.doc(productId.toString()).get();
      // Check if the document exists in the wishlist collection

      return docSnapshot.exists;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Error checking wishlist status');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
