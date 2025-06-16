import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600; // Changed to better detect mobile
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * (isSmallScreen ? 0.35 : 0.4),
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: isSmallScreen ? 60 : 100,
                          color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 16 : 24,
                    vertical: isSmallScreen ? 16 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title and Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                              fontSize: isSmallScreen
                                  ? theme.textTheme.titleLarge?.fontSize
                                  : theme.textTheme.headlineSmall?.fontSize,
                            ),
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 16),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen
                                ? theme.textTheme.titleLarge?.fontSize
                                : theme.textTheme.headlineSmall?.fontSize,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? 8 : 16),

                    // Rating and Stock
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 6 : 8,
                            vertical: isSmallScreen ? 2 : 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: isSmallScreen ? 16 : 18,
                              ),
                              SizedBox(width: isSmallScreen ? 2 : 4),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 6 : 12),
                        Icon(
                          Icons.inventory_2_outlined,
                          size: isSmallScreen ? 16 : 18,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        SizedBox(width: isSmallScreen ? 2 : 4),
                        Text(
                          '${product.stock} in stock',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? 16 : 32),

                    // Description Section
                    Text(
                      'Description',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen
                            ? theme.textTheme.titleMedium?.fontSize
                            : theme.textTheme.titleLarge?.fontSize,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 12),
                    Text(
                      product.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 24 : 40),

                    // Add to Cart Button - Now full width
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: EdgeInsets.only(
                                bottom: size.height * 0.1,
                                left: isSmallScreen ? 16 : size.width * 0.3,
                                right: isSmallScreen ? 16 : size.width * 0.3,
                              ),
                              backgroundColor: theme.colorScheme.primary,
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: isSmallScreen ? 20 : 24,
                                  ),
                                  SizedBox(width: isSmallScreen ? 8 : 12),
                                  Flexible(
                                    child: Text(
                                      '${product.name} added to cart',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isSmallScreen ? 14 : 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              action: SnackBarAction(
                                label: 'VIEW',
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: isSmallScreen ? 16 : 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              size: isSmallScreen ? 20 : 24,
                            ),
                            SizedBox(width: isSmallScreen ? 8 : 12),
                            Text(
                              'ADD TO CART',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 16 : 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}