import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/order.dart';
import '../../orders.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource dataSource;
  OrdersRepositoryImpl({required this.dataSource});

  @override
  ResultFuture<List<OrderEntity>> fetchOrders() async {
    try {
      final orders = await dataSource.fetchOrders();
      return Right(orders);
    } on OrdersException catch (e) {
      return Left(ApiFailure(e.message, e.code));
    } catch (_) {
      return Left(
        ApiFailure(
          'Unexpected error occurred while fetching orders',
          'unknown',
        ),
      );
    }
  }
}
