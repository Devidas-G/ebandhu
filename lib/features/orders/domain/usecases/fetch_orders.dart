import 'package:ebandhu/features/orders/domain/entities/order.dart';

import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../orders.dart';

class FetchOrders implements UseCase<List<OrderEntity>, NoParams> {
  final OrdersRepository repository;

  FetchOrders(this.repository);

  @override
  ResultFuture<List<OrderEntity>> call(NoParams params) {
    return repository.fetchOrders();
  }
}
