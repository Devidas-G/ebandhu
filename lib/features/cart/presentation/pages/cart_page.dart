import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart.dart';
import '../widgets/cart_listview.dart';

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
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is ProductRemovedFromCart) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.product.title} removed from cart"),
              ),
            );
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              //if cart is empty, show a message
              if (state.cartProducts.isEmpty) {
                return Center(child: Text("Your cart is empty"));
              }
              return CartListview(
                cartProducts: state.cartProducts,
                onRemove: (cartProduct) {
                  context.read<CartBloc>().add(
                    RemoveProductFromCartEvent(cartProduct.product),
                  );
                },
              );
            } else if (state is CartError) {
              return Center(
                child: Text("Error loading cart: ${state.message}"),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
