import 'package:bookstore_app/modules/cart/model/cart_item_model.dart';
import 'package:bookstore_app/modules/products/model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart'; // ← updated import

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [])) {
    on<CartEventAdd>(_onCartEventAdd);
    on<CartEventRemove>(_onCartEventRemove);
    on<CartEventUpdateQuantity>(_onCartEventUpdateQuantity);
    on<CartEventClear>((_, emit) => emit(CartState(items: [])));
  }

  void _onCartEventAdd(CartEventAdd event, Emitter<CartState> emit) {
    debugPrint('[CartBloc] Adding product: ${event.product.title}');
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
    debugPrint('[CartBloc] Removing product: ${event.productId}');
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
    debugPrint(
      '[CartBloc] Updating quantity for ${event.productId} to ${event.quantity}',
    );
    final updatedItems =
        state.items.map((item) {
          return item.product.id == event.productId
              ? item.copyWith(quantity: event.quantity)
              : item;
        }).toList();

    emit(state.copyWith(items: updatedItems));
  }

  // 🟢 Required for persistence
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
