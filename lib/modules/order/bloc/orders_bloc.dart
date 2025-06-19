import 'dart:async';

import 'package:bookstore_app/modules/order/model/order_item_model.dart';
import 'package:bookstore_app/modules/order/model/order_model.dart';
import 'package:bookstore_app/modules/order/service/order_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersStateInitial()) {
    on<OrdersEventLoad>(_onOrdersEventLoad);
    on<OrdersEventLoadDetails>(_onOrdersEventLoadDetails);
  }

  final orderService = OrderService();

  Future<void> _onOrdersEventLoad(
    OrdersEventLoad event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersStateLoading());
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      final data = await orderService.fetchUserOrders(userId);
      emit(OrdersStateLoaded(data));
    } catch (e) {
      emit(OrdersStateError(e.toString()));
    }
  }

  Future<void> _onOrdersEventLoadDetails(
    OrdersEventLoadDetails event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersStateDetailsLoading());
    try {
      final order = await orderService.fetchOrderById(event.orderId);
      final items = await orderService.fetchOrderItems(event.orderId);
      emit(OrdersStateDetailsLoaded(order: order, items: items));
    } catch (e) {
      emit(OrdersStateError(e.toString()));
    }
  }
}
