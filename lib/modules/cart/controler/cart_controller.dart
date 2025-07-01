import 'package:bookstore_app/modules/cart/bloc/cart_bloc.dart';
import 'package:bookstore_app/modules/cart/model/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartController {
  final BuildContext context;

  CartController(this.context);

  void updateQuantity(String productId, int quantity) {
    context.read<CartBloc>().add(
      CartEventUpdateQuantity(productId: productId, quantity: quantity),
    );
  }

  void removeFromCart(String productId) {
    context.read<CartBloc>().add(CartEventRemove(productId: productId));
  }

  void clearCart() {
    context.read<CartBloc>().add(CartEventClear());
  }

  void checkout(List<CartItemModel> items) {
    context.read<CartBloc>().add(CartEventCheckout(items: items));
  }

  void checkoutWithAddress(
    List<CartItemModel> items,
    Map<String, dynamic> address,
  ) {
    context.read<CartBloc>().add(
      CartEventCheckout(items: items, address: address),
    );
  }
}
