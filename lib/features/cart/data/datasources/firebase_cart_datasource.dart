import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/exception.dart';
import '../models/cart_product.dart'; // now includes quantity + product
import 'cart_remote_datasource.dart';

//! Warning: accessing Firestore directly in the datasource,
//! any data structure changes will cause issues.
//! use a middleware api with version control to handle data structure changes

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
  Future<List<CartProduct>> fetchCartItems() async {
    try {
      final snapshot = await _cartRef.get();
      return snapshot.docs
          .map((doc) => CartProduct.fromJson(doc.data()))
          .toList();
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
  Future<List<CartProduct>> addToCart(CartProduct cartProduct) async {
    try {
      // First, check if item already exists
      final doc = await _cartRef.doc(cartProduct.product.id.toString()).get();

      if (doc.exists) {
        throw CartException(
          message: "Item already exists in cart",
          code: 'item_exists',
        );
      } else {
        await _cartRef
            .doc(cartProduct.product.id.toString())
            .set(cartProduct.toJson());
      }
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
  Future<List<CartProduct>> removeFromCart(int productId) async {
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

  @override
  Future<List<CartProduct>> updateItemInCart(CartProduct cartProduct) async {
    try {
      await _cartRef
          .doc(cartProduct.product.id.toString())
          .update(cartProduct.toJson());
      return await fetchCartItems();
    } on FirebaseException catch (e) {
      throw CartException(
        message: e.message ?? 'Failed to update item',
        code: e.code,
      );
    } catch (e) {
      throw CartException(message: e.toString());
    }
  }
}
