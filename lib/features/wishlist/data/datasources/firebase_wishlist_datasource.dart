import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebandhu/core/common/model/product.dart';

import '../../../../core/errors/exception.dart';
import 'wishlist_remote_datasource.dart';

class FirebaseWishlistDatasource implements WishlistRemoteDataSource {
  final FirebaseFirestore firestore;
  final String? userId;

  FirebaseWishlistDatasource({required this.firestore, required this.userId}) {
    if (userId == null || userId!.isEmpty) {
      throw WishlistException(
        message: 'User is not authenticated.',
        code: 'unauthenticated',
      );
    }
  }

  CollectionReference<Map<String, dynamic>> get _wishlistRef =>
      firestore.collection('users').doc(userId).collection('wishlist');

  @override
  Future<List<Product>> fetchWishlist() async {
    try {
      final snapshot = await _wishlistRef.get();
      return snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw WishlistException(
        message: e.message ?? 'Firestore error',
        code: e.code,
      );
    } catch (e) {
      throw WishlistException(message: e.toString());
    }
  }

  @override
  Future<List<Product>> addToWishlist(Product product) async {
    try {
      await _wishlistRef.doc(product.id.toString()).set(product.toJson());
      return await fetchWishlist();
    } on FirebaseException catch (e) {
      throw WishlistException(
        message: e.message ?? 'Failed to add item',
        code: e.code,
      );
    } on WishlistException {
      rethrow;
    } catch (e) {
      throw WishlistException(message: e.toString());
    }
  }

  @override
  Future<List<Product>> removeFromWishlist(int productId) async {
    try {
      await _wishlistRef.doc(productId.toString()).delete();
      return await fetchWishlist();
    } on FirebaseException catch (e) {
      throw WishlistException(
        message: e.message ?? 'Failed to remove item',
        code: e.code,
      );
    } on WishlistException {
      rethrow;
    } catch (e) {
      throw WishlistException(message: e.toString());
    }
  }

  @override
  Future<void> clearWishlist() async {
    try {
      final snapshot = await _wishlistRef.get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw WishlistException(
        message: e.message ?? 'Failed to clear wishlist',
        code: e.code,
      );
    } catch (e) {
      throw WishlistException(message: e.toString());
    }
  }
}
