import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/modules/cart/bloc/cart_bloc.dart';
import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:bookstore_app/modules/cart/controler/cart_controller.dart';
import 'package:bookstore_app/modules/cart/view/widget/cart_item_card.dart';
import 'package:bookstore_app/modules/cart/view/widget/cart_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Text('Your Cart (${state.items.length} items)');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Clear Cart',
            onPressed: controller.clearCart,
          ),
        ],
      ),

      /// BlocListener for SnackBar feedback
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartStateError) {
            showSnackBar(
              context,
              message: state.message,
              type: SnackbarType.error,
            );
          } else if (state.items.isEmpty) {
            showSnackBar(
              context,
              message: 'Order placed successfully!',
              type: SnackbarType.success,
            );
          }
        },

        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final items = state.items;

            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'Your cart is empty.',
                  style: TextStyle(fontSize: 16, color: AppTheme.dustyGrey),
                ),
              );
            }

            final total = state.total;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return CartItemCard(item: item);
                    },
                  ),
                ),
                CartSummary(
                  total: total,
                  onCheckout: () => controller.checkout(items),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
