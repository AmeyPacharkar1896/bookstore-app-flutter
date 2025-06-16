import 'package:bookstore_app/modules/cart/controler/cart_controller.dart';
import 'package:bookstore_app/modules/cart/model/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = CartController(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                item.product.coverUrl ?? '',
                width: 60,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.book, size: 60),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title, style: textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(item.product.author, style: textTheme.bodySmall),
                  const SizedBox(height: 6),
                  Text(
                    '₹${item.product.price} x ${item.quantity}',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (item.quantity > 1) {
                            controller.updateQuantity(
                              item.product.id,
                              item.quantity - 1,
                            );
                          }
                        },
                      ),
                      Text('${item.quantity}', style: textTheme.bodyLarge),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          controller.updateQuantity(
                            item.product.id,
                            item.quantity + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Remove',
              onPressed: () {
                controller.removeFromCart(item.product.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
