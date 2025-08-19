import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/errors/exception.dart';
import '../models/order_model.dart';
import 'orders_remote_datasource.dart';

class FirebaseOrdersDataSource implements OrdersRemoteDataSource {
  final FirebaseFirestore firestore;
  final String? userId;

  FirebaseOrdersDataSource({required this.firestore, required this.userId}) {
    if (userId == null || userId!.isEmpty) {
      throw OrdersException(
        message: 'User is not authenticated.',
        code: 'unauthenticated',
      );
    }
  }

  CollectionReference<Map<String, dynamic>> get _ordersRef =>
      firestore.collection('users').doc(userId).collection('orders');

  @override
  Future<List<OrderModel>> fetchOrders() async {
    try {
      final snapshot = await _ordersRef.get();
      return snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw OrdersException(
        message: e.message ?? 'Firestore error',
        code: e.code,
      );
    } catch (e) {
      throw OrdersException(message: e.toString());
    }
  }
}
