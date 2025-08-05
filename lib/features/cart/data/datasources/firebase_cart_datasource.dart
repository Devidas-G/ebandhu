import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/exception.dart';
import '../models/cart_product.dart'; // now includes quantity + product
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

      int newQuantity = 1;
      if (doc.exists) {
        final existingCartProduct = CartProduct.fromJson(doc.data()!);
        newQuantity = existingCartProduct.quantity + 1;
      }

      final newCartProduct = CartProduct(
        product: cartProduct.product,
        quantity: newQuantity,
      );

      await _cartRef
          .doc(cartProduct.product.id.toString())
          .set(newCartProduct.toJson());

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
}
