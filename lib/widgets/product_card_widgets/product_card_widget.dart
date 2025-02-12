import 'package:flutter/material.dart';
import 'package:oru_copy/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Let the column shrink-wrap its content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and overlayed badges
          Stack(
            children: [
              // Reduce image height by increasing aspectRatio value (width/height)
              AspectRatio(
                aspectRatio: 1.3,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: product.thumbnailUrl != null
                      ? Image.network(
                          product.thumbnailUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'assets/icons/Logo.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              // Verified badge
              if (product.isVerified)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Text(
                      'ORUVerified',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              // Favorite icon
              Positioned(
                top: 8,
                right: 8,
                child:
                    Icon(Icons.favorite_border, color: Colors.white, size: 22),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: // Price Negotiable Banner
                    Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 25,
                    color: Colors.grey.withValues(alpha: 0.8),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    alignment: Alignment.center,
                    child: const Text(
                      'PRICE NEGOTIABLE',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),

          // Product details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  product.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Product specifications (RAM/Storage/Condition)
                Text(
                  '${product.ram}/${product.storage} GB • ${product.condition}',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 8),
                // Pricing row
                Row(
                  children: [
                    Text(
                      '₹${product.currentPrice}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '₹${product.originalPrice}',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '(${product.discountPercentage}% off)',
                        style: TextStyle(color: Colors.red, fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Location and Date row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 14, color: Colors.grey[700]),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              product.location,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false, // Ensures single-line ellipsis
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5), // Prevents touching edges
                    Text(
                      product.datePosted,
                      style: TextStyle(color: Colors.grey[700], fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
