import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartSummary extends StatelessWidget {
  final double total;
  final VoidCallback onCheckout;

  const CartSummary({super.key, required this.total, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.softPageWhite,
        border: Border(top: BorderSide(color: AppTheme.lightMistGrey)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: textTheme.titleLarge),
              Text(
                '₹${total.toStringAsFixed(2)}',
                style: textTheme.titleLarge?.copyWith(
                  color: AppTheme.deepTeal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onCheckout,
              icon: const Icon(Icons.payment),
              label: const Text('Proceed to Checkout'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.go('/home'),
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Continue Shopping'),
            ),
          ),
        ],
      ),
    );
  }
}
