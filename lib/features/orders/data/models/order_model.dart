import '../../domain/entities/order.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.total,
    required super.status,
    required super.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      items:
          (json['items'] as List)
              .map(
                (item) => OrderItem(
                  productId: item['productId'],
                  name: item['name'],
                  quantity: item['quantity'],
                  price: (item['price'] as num).toDouble(),
                ),
              )
              .toList(),
      total: (json['total'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items':
          items
              .map(
                (e) => {
                  'productId': e.productId,
                  'name': e.name,
                  'quantity': e.quantity,
                  'price': e.price,
                },
              )
              .toList(),
      'total': total,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
