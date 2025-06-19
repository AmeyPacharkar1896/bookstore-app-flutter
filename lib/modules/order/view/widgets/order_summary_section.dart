
import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:bookstore_app/modules/order/model/order_model.dart';
import 'package:bookstore_app/modules/order/view/widgets/status_badge.dart';
import 'package:flutter/material.dart';

class OrderSummarySection extends StatelessWidget {
  final OrderModel order;

  const OrderSummarySection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order ID: ${order.id}', style: textTheme.labelLarge),
        const SizedBox(height: 6),
        Row(
          children: [
            Text('Status: ', style: textTheme.bodyMedium),
            StatusBadge(status: order.status),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Placed on: ${order.createdAt.toLocal().toString().split(" ").first}',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        Text(
          'Total: ₹${order.totalAmount.toStringAsFixed(2)}',
          style: AppTheme.totalAmountTextStyle,
        ),
        const SizedBox(height: 16),
        const Divider(color: AppTheme.lightMistGrey),
      ],
    );
  }
}