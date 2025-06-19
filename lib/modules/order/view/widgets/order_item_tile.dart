import 'package:bookstore_app/modules/order/model/order_item_model.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItemModel item;

  const OrderItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: item.product['cover_url'] != null && item.product['cover_url'].toString().isNotEmpty
              ? Image.network(
                  item.product['cover_url'],
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 50,
                  height: 70,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.book, color: Colors.grey),
                ),
        ),
        title: Text(
          item.product['title'] ?? 'Unknown Title',
          style: textTheme.bodyLarge,
        ),
        subtitle: Text(
          'Qty: ${item.quantity}',
          style: textTheme.bodyMedium,
        ),
        trailing: Text(
          '₹${item.price.toStringAsFixed(2)}',
          style: textTheme.bodyLarge,
        ),
      ),
    );
  }
}
