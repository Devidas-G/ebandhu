import 'package:ebandhu/features/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/order_card.dart';

class OrdersTabPage extends StatelessWidget {
  const OrdersTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrdersLoaded) {
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return OrderCard(order: order);
            },
          );
        } else {
          return const Center(child: Text('Failed to load orders'));
        }
      },
    );
  }
}
