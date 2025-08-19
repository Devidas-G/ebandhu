import '../models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> fetchOrders();
}
