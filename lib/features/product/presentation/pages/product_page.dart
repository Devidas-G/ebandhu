import 'package:ebandhu/features/product/presentation/widgets/product_error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../widgets/product_loaded_page.dart';
import '../widgets/product_loading_page.dart';

class ProductPage extends StatefulWidget {
  final int productId;

  const ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
      FetchProductEvent(productId: widget.productId),
    );
    context.read<ProductBloc>().add(
      CheckFavoriteStatusEvent(productId: widget.productId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Product Detials"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag_outlined)),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial || state is ProductLoading) {
            return ProductLoadingPage();
          } else if (state is ProductLoaded) {
            return ProductLoadedPage(
              product: state.product,
              isFavorite: state.isFavorite,
            );
          } else {
            return ProductErrorPage(
              onTap: () {
                context.read<ProductBloc>().add(
                  FetchProductEvent(productId: widget.productId),
                );
              },
              errorMessage:
                  (state is ProductError)
                      ? state.errorMessage
                      : 'An error occurred',
            );
          }
        },
      ),
    );
  }
}
