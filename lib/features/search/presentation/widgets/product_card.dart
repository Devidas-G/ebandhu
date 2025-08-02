import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onFavoriteToggle,
    required this.onTap,
    required this.isFavorited,
  });

  final ProductEntity product;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;
  final bool isFavorited;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    errorBuilder:
                        (_, __, ___) =>
                            const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
              const SizedBox(height: 4),

              // Title and Price
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(product.category, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 4),
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: onFavoriteToggle,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.grey.withValues(alpha: 0.4),
                foregroundColor: Colors.white, // Icon color
              ),
              child: Icon(
                size: 25,
                isFavorited ? Icons.favorite : Icons.favorite_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
