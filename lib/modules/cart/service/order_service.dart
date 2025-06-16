import 'dart:developer';

import 'package:bookstore_app/modules/cart/model/cart_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderService {
  final SupabaseClient _client;

  OrderService(this._client);

  Future<void> createOrder({
    required String userId,
    required List<CartItemModel> items,
  }) async {
    try {
      final total = items.fold(0.0, (sum, item) => sum + item.totalPrice);
      log('[OrderService] Creating order for user: $userId');
      log('[OrderService] Total amount: ₹$total');

      final orderRes =
          await _client
              .from('orders')
              .insert({
                'user_id': userId,
                'total_amount': total,
                'order_status': 'pending',
              })
              .select()
              .single();

      final orderId = orderRes['id'] as String;
      log('[OrderService] Order created with ID: $orderId');

      for (final item in items) {
        await _client.from('order_items').insert({
          'order_id': orderId,
          'product_id': item.product.id,
          'quantity': item.quantity,
          'price': item.product.price,
        });
        log(
          '[OrderService] Inserted item: '
          '${item.product.title} (x${item.quantity}) - ₹${item.product.price}',
        );
      }

      log('[OrderService] All order items inserted successfully.');
    } catch (e, stackTrace) {
      log('[OrderService] Error creating order: $e');
      log('[OrderService] StackTrace:\n$stackTrace');
      rethrow; // Optional: rethrow if you want to handle it elsewhere too
    }
  }
}
