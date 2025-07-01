import 'package:bookstore_app/modules/cart/model/cart_item_model.dart';
import 'package:bookstore_app/modules/cart/service/cart_service.dart';
import 'package:bookstore_app/modules/products/model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [])) {
    on<CartEventAdd>(_onCartEventAdd);
    on<CartEventRemove>(_onCartEventRemove);
    on<CartEventUpdateQuantity>(_onCartEventUpdateQuantity);
    on<CartEventClear>((_, emit) => emit(CartState(items: [])));
    on<CartEventCheckout>(_onCartEventCheckout);
  }

  void _onCartEventAdd(CartEventAdd event, Emitter<CartState> emit) {
    final existing = state.items.firstWhere(
      (item) => item.product.id == event.product.id,
      orElse: () => CartItemModel(product: event.product, quantity: 0),
    );

    final updatedItems =
        state.items
            .where((item) => item.product.id != event.product.id)
            .toList()
          ..add(existing.copyWith(quantity: existing.quantity + 1));

    emit(state.copyWith(items: updatedItems));
  }

  void _onCartEventRemove(CartEventRemove event, Emitter<CartState> emit) {
    emit(
      state.copyWith(
        items:
            state.items
                .where((item) => item.product.id != event.productId)
                .toList(),
      ),
    );
  }

  void _onCartEventUpdateQuantity(
    CartEventUpdateQuantity event,
    Emitter<CartState> emit,
  ) {
    final updatedItems =
        state.items.map((item) {
          return item.product.id == event.productId
              ? item.copyWith(quantity: event.quantity)
              : item;
        }).toList();

    emit(state.copyWith(items: updatedItems));
  }

  Future<void> _onCartEventCheckout(
    CartEventCheckout event,
    Emitter<CartState> emit,
  ) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) {
      emit(
        CartStateError(message: 'You must be logged in.', items: state.items),
      );
      return;
    }

    if (event.items.isEmpty) {
      emit(CartStateError(message: 'Your cart is empty.', items: state.items));
      return;
    }

    try {
      await CartService().createOrder(
        userId: userId,
        items: event.items,
        address: event.address,
      );
      emit(CartState(items: []));
    } catch (e) {
      emit(CartStateError(message: e.toString(), items: state.items));
    }
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    try {
      final itemsJson = json['items'] as List<dynamic>;
      final items =
          itemsJson
              .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return CartState(items: items);
    } catch (e) {
      debugPrint('[CartBloc] fromJson error: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    try {
      return {'items': state.items.map((e) => e.toJson()).toList()};
    } catch (e) {
      debugPrint('[CartBloc] toJson error: $e');
      return null;
    }
  }
}
