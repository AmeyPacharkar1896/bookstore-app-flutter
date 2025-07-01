import 'package:bookstore_app/modules/cart/model/cart_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartService {
  final _client = Supabase.instance.client;

  Future<void> createOrder({
    required String userId,
    required List<CartItemModel> items,
    Map<String, dynamic>? address,
  }) async {
    try {
      final total = items.fold(0.0, (sum, item) => sum + item.totalPrice);

      final orderRes =
          await _client
              .from('orders')
              .insert({
                'user_id': userId,
                'total_amount': total,
                'order_status': 'pending',
                if (address != null) 'shipping_address': address,
              })
              .select()
              .single();

      final orderId = orderRes['id'] as String;

      for (final item in items) {
        await _client.from('order_items').insert({
          'order_id': orderId,
          'product_id': item.product.id,
          'quantity': item.quantity,
          'price': item.product.price,
        });
      }
    } catch (e) {
      throw Exception('Failed to place order. Please try again.');
    }
  }
}
