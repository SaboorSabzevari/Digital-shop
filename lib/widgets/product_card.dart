import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onViewDetails;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 350;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onViewDetails,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: theme.cardTheme.color,
                    child: Icon(
                      Icons.image,
                      size: isSmallScreen ? 30 : 50,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen
                          ? theme.textTheme.titleSmall?.fontSize
                          : theme.textTheme.titleMedium?.fontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isSmallScreen ? 2 : 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: isSmallScreen ? 14 : 16,
                      ),
                      SizedBox(width: isSmallScreen ? 2 : 4),
                      Text(
                        '${product.rating}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: isSmallScreen
                              ? theme.textTheme.bodySmall?.fontSize!
                          //0.9
                              : theme.textTheme.bodySmall?.fontSize,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen
                              ? theme.textTheme.titleSmall?.fontSize
                              : theme.textTheme.titleMedium?.fontSize,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 8 : 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onViewDetails,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 6 : 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 4 : 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onAddToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 6 : 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}