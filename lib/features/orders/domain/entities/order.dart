import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double total;
  final String status; // e.g., pending, shipped, delivered
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, items, total, status, createdAt];
}

class OrderItem extends Equatable {
  final String productId;
  final String name;
  final int quantity;
  final double price;

  const OrderItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [productId, name, quantity, price];
}
