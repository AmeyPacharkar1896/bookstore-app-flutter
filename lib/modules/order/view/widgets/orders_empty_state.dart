import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrdersEmptyState extends StatelessWidget {
  const OrdersEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag_outlined, size: 80, color: AppTheme.dustyGrey),
            const SizedBox(height: 24),
            const Text(
              'No orders yet!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppTheme.inkBlack,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Start exploring our collection and find your next favorite book.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppTheme.dustyGrey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.deepTeal,
                foregroundColor: AppTheme.softPageWhite,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Shop Now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
