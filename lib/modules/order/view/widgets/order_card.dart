import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:bookstore_app/modules/order/model/order_model.dart';
import 'package:bookstore_app/modules/order/view/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = order.createdAt.toLocal().toString().split(' ').first;
    final total = '₹${order.totalAmount.toStringAsFixed(2)}';
    final status = order.status.toUpperCase();

    return InkWell(
      onTap: () => context.go('/orders/${order.id}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.softPageWhite,
          border: Border.all(color: AppTheme.lightMistGrey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Order number and status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id.substring(0, 6)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.inkBlack,
                  ),
                ),
                StatusBadge(status: status),
              ],
            ),
            const SizedBox(height: 8),
            // Bottom row: Date • Total and arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$date • $total',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.dustyGrey,
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppTheme.deepTeal),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

