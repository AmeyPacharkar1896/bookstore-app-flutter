part of 'orders_bloc.dart';

abstract class OrdersEvent {}

class OrdersEventLoad extends OrdersEvent {}

class OrdersEventLoadDetails extends OrdersEvent {
  final String orderId;

  OrdersEventLoadDetails({required this.orderId});
}
