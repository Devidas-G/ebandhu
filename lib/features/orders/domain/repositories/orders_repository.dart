import '../../../../core/utils/typedef.dart';
import '../entities/order.dart';

abstract class OrdersRepository {
  ResultFuture<List<OrderEntity>> fetchOrders();
}
