import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/wishlist_bloc.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  createState() => _WishlistPage();
}

class _WishlistPage extends State<WishlistPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(FetchWishlistEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("My Favourite"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.search),
                hintText: "Search products...",
                suffixIcon: IconButton(
                  onPressed: () {
                    print("object");
                  },
                  icon: Icon(Icons.settings),
                ),
              ),
              onChanged: (query) {
                // TODO: Add search logic
              },
            ),
          ),
        ),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WishlistLoaded) {
              //if wishlist is empty, show a message
              if (state.products.isEmpty) {
                return Center(child: Text("Your wishlist is empty"));
              }
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text("Price: \$${product.price}"),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        context.read<WishlistBloc>().add(
                          RemoveProductFromWishlistEvent(product.id),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is WishlistError) {
              return Center(
                child: Text("Error loading wishlist: ${state.message}"),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
