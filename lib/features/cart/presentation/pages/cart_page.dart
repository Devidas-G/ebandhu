import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart.dart';

class CartPage extends StatefulWidget {
  @override
  createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("My Cart"),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            //if cart is empty, show a message
            if (state.cartProducts.isEmpty) {
              return Center(child: Text("Your cart is empty"));
            }
            return ListView.builder(
              itemCount: state.cartProducts.length,
              itemBuilder: (context, index) {
                final product = state.cartProducts[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text("Price: \$${product.price}"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      context.read<CartBloc>().add(RemoveItemEvent(product.id));
                    },
                  ),
                );
              },
            );
          } else if (state is CartError) {
            return Center(child: Text("Error loading cart: ${state.message}"));
          }
          return Container();
        },
      ),
    );
  }
}
