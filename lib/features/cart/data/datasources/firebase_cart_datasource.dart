import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/exception.dart';
import '../models/product.dart';
import 'cart_remote_datasource.dart';

class FirebaseCartDatasource implements CartRemoteDataSource {
  final FirebaseFirestore firestore;
  final String? userId;

  FirebaseCartDatasource({required this.firestore, required this.userId}) {
    if (userId == null || userId!.isEmpty) {
      throw CartException(
        message: 'User is not authenticated.',
        code: 'unauthenticated',
      );
    }
  }

  CollectionReference<Map<String, dynamic>> get _cartRef =>
      firestore.collection('users').doc(userId).collection('cart');

  @override
  Future<List<Product>> fetchCartItems() async {
    try {
      final snapshot = await _cartRef.get();
      return snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw CartException(
        message: e.message ?? 'Firestore error',
        code: e.code,
      );
    } catch (e) {
      throw CartException(message: e.toString());
    }
  }

  @override
  Future<List<Product>> addToCart(Product product) async {
    try {
      await _cartRef.doc(product.id.toString()).set(product.toJson());
      return await fetchCartItems();
    } on FirebaseException catch (e) {
      throw CartException(
        message: e.message ?? 'Failed to add item',
        code: e.code,
      );
    } on CartException {
      rethrow;
    } catch (e) {
      throw CartException(message: e.toString());
    }
  }

  @override
  Future<List<Product>> removeFromCart(int productId) async {
    try {
      await _cartRef.doc(productId.toString()).delete();
      return await fetchCartItems();
    } on FirebaseException catch (e) {
      throw CartException(
        message: e.message ?? 'Failed to remove item',
        code: e.code,
      );
    } on CartException {
      rethrow;
    } catch (e) {
      throw CartException(message: e.toString());
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final snapshot = await _cartRef.get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw CartException(
        message: e.message ?? 'Failed to clear cart',
        code: e.code,
      );
    } catch (e) {
      throw CartException(message: e.toString());
    }
  }
}
