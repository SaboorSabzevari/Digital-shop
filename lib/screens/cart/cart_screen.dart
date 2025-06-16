import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import '../../models/product.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;
  final Function(Product) removeFromCart;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.removeFromCart,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin {
  void removeFromCart(Product product) {
    setState(() {
      widget.cartItems.remove(product);
    });
  }
  int get quantity => widget.cartItems.length;
  int getQuantity(){
    late int getCount;
    setState(() {
       getCount=widget.cartItems.length;
    });
    return getCount;
  }

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get totalPrice {
    return widget.cartItems.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 350;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen
                ? theme.textTheme.titleMedium?.fontSize
                : theme.textTheme.titleLarge?.fontSize,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.cartItems.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: isSmallScreen ? 48 : 64,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
              SizedBox(height: isSmallScreen ? 16 : 24),
              Text(
                'Your cart is empty',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  fontSize: isSmallScreen
                      ? theme.textTheme.titleMedium?.fontSize
                      : theme.textTheme.titleLarge?.fontSize,
                ),
              ),
              SizedBox(height: isSmallScreen ? 8 : 12),
              Text(
                'Add some products to your cart',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: isSmallScreen ? 24 : 32),
              SizedBox(
                width: size.width * (isSmallScreen ? 0.8 : 0.6),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 12 : 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continue Shopping',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
            : Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      isSmallScreen ? 12 : 16,
                      isSmallScreen ? 12 : 16,
                      isSmallScreen ? 12 : 16,
                      0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final product = widget.cartItems[index];
                          return _buildCartItem(
                            context,
                            product,
                            theme,
                            isSmallScreen,
                          );
                        },
                        childCount: widget.cartItems.length,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      bottom: isSmallScreen ? 80 : 100,
                    ),
                  ),
                ],
              ),
            ),
            _buildCheckoutPanel(theme, isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(
      BuildContext context,
      Product product,
      ThemeData theme,
      bool isSmallScreen,
      ) {
    return Dismissible(
      key: Key(product.id),
      background: Container(
        margin: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: isSmallScreen ? 16 : 20),
        child: Icon(
          Icons.delete_forever,
          color: Colors.red[400],
          size: isSmallScreen ? 24 : 30,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        removeFromCart(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: theme.colorScheme.error,
            content: Row(
              children: [
                Icon(Icons.delete, color: Colors.white, size: isSmallScreen ? 20 : 24),
                SizedBox(width: isSmallScreen ? 4 : 8),
                Text(
                  '${product.name} removed from cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ],
            ),
            action: SnackBarAction(
              label: 'UNDO',
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  widget.cartItems.insert(
                    widget.cartItems.indexOf(product),
                    product,
                  );
                });
              },
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.imageUrl,
                  width: isSmallScreen ? 60 : 80,
                  height: isSmallScreen ? 60 : 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: isSmallScreen ? 60 : 80,
                    height: isSmallScreen ? 60 : 80,
                    color: theme.cardTheme.color,
                    child: Icon(
                      Icons.image,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
              SizedBox(width: isSmallScreen ? 8 : 16),
              Expanded(
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isSmallScreen ? 2 : 4),
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
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: theme.colorScheme.error,
                  size: isSmallScreen ? 20 : 24,
                ),
                onPressed: () => widget.removeFromCart(product),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutPanel(ThemeData theme, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  fontSize: isSmallScreen
                      ? theme.textTheme.bodyMedium?.fontSize
                      : theme.textTheme.bodyLarge?.fontSize,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  fontSize: isSmallScreen
                      ? theme.textTheme.bodyMedium?.fontSize
                      : theme.textTheme.bodyLarge?.fontSize,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 4 : 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'quantity',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  fontSize: isSmallScreen
                      ? theme.textTheme.bodyMedium?.fontSize
                      : theme.textTheme.bodyLarge?.fontSize,
                ),
              ),
              Text(
                '${getQuantity()}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  fontSize: isSmallScreen
                      ? theme.textTheme.bodyMedium?.fontSize
                      : theme.textTheme.bodyLarge?.fontSize,
                ),
              ),
            ],
          ),
          Divider(height: isSmallScreen ? 24 : 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen
                      ? theme.textTheme.titleMedium?.fontSize
                      : theme.textTheme.titleLarge?.fontSize,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen
                      ? theme.textTheme.titleMedium?.fontSize
                      : theme.textTheme.titleLarge?.fontSize,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),
          SizedBox(
            width: double.infinity,
            height: isSmallScreen ? 48 : 56,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: theme.colorScheme.primary,
                    content: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: isSmallScreen ? 20 : 24,
                        ),
                        SizedBox(width: isSmallScreen ? 4 : 8),
                        Text(
                          'Order placed successfully!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ],
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
              ),
              child: Text(
                'CHECKOUT',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}