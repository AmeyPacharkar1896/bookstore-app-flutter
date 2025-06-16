import 'dart:developer';
import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/modules/cart/bloc/cart_bloc.dart';
import 'package:bookstore_app/modules/cart/model/cart_item_model.dart';
import 'package:bookstore_app/modules/cart/service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartController {
  final BuildContext context;

  CartController(this.context);

  void updateQuantity(String productId, int quantity) {
    context.read<CartBloc>().add(CartEventUpdateQuantity(
      productId: productId,
      quantity: quantity,
    ));
  }

  void removeFromCart(String productId) {
    context.read<CartBloc>().add(CartEventRemove(productId: productId));
  }

  void clearCart() {
    context.read<CartBloc>().add(CartEventClear());
  }

  Future<void> checkout(List<CartItemModel> items) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      showSnackBar(context, message: 'User not logged in');
      return;
    }

    if (items.isEmpty) {
      showSnackBar(context, message: 'Your cart is empty');
      return;
    }

    try {
      await OrderService(Supabase.instance.client).createOrder(
        userId: userId,
        items: items,
      );
      clearCart();
      showSnackBar(context, message: 'Order placed successfully!');
    } catch (e, st) {
      log('Checkout error: $e\n$st');
      showSnackBar(
        context,
        message: 'Checkout failed',
        type: SnackbarType.error,
      );
    }
  }
}
