import 'dart:developer' show log;

import 'package:bookstore_app/modules/order/model/order_item_model.dart';
import 'package:bookstore_app/modules/order/model/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderService {
  final _client = Supabase.instance.client;

  OrderService();

  /// Fetch all orders for a given user
  Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try {
      log('[OrderService] Fetching orders for user: $userId');
      final List<dynamic> response = await _client
          .from('orders')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return response
          .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('[OrderService] Error fetching user orders: $e');
      rethrow;
    }
  }

  /// Fetch single order details (basic)
  Future<OrderModel> fetchOrderById(String orderId) async {
    try {
      log('[OrderService] Fetching order by ID: $orderId');
      final Map<String, dynamic> response =
          await _client.from('orders').select().eq('id', orderId).single();

      return OrderModel.fromJson(response);
    } catch (e) {
      log('[OrderService] Error fetching order by ID: $e');
      rethrow;
    }
  }

  /// Fetch all order items for a specific order, joined with product details
  Future<List<OrderItemModel>> fetchOrderItems(String orderId) async {
    try {
      log('[OrderService] Fetching items for order: $orderId');
      final List<dynamic> response = await _client
          .from('order_items')
          .select('*, products(*)') // Join with products
          .eq('order_id', orderId);

      return response
          .map((json) => OrderItemModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('[OrderService] Error fetching order items: $e');
      rethrow;
    }
  }
}
