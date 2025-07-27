import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductLoadedPage extends StatelessWidget {
  const ProductLoadedPage({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              // Display product image
              SizedBox(height: 300, child: Image.network(product.image)),
              // Display product name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              // rating
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text(
                      "${product.rating['rate']} (${product.rating['count']} reviews)",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              // Display product price
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "\$${product.price}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              // Display product description
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      product.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // bottom buttons for add to cart and buy now
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(
                          context,
                        ).scaffoldBackgroundColor, // Set background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    // Handle add to cart action
                  },
                  child: Text(
                    "Add to Cart",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    // Handle buy now action
                  },
                  child: Text(
                    "Buy Now",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
