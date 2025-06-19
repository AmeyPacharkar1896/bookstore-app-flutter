part of 'orders_bloc.dart';

abstract class OrdersState {}

class OrdersStateInitial extends OrdersState {}

class OrdersStateLoading extends OrdersState {}

class OrdersStateLoaded extends OrdersState {
  final List<OrderModel> orders;
  OrdersStateLoaded(this.orders);
}

class OrdersStateDetailsLoading extends OrdersState {}

class OrdersStateDetailsLoaded extends OrdersState {
  final OrderModel order;
  final List<OrderItemModel> items;

  OrdersStateDetailsLoaded({required this.order, required this.items});
}

class OrdersStateError extends OrdersState {
  final String message;
  OrdersStateError(this.message);
}
