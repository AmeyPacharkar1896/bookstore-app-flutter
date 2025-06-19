import 'package:bookstore_app/modules/order/bloc/orders_bloc.dart';
import 'package:bookstore_app/modules/order/view/order_details_screen.dart';
import 'package:bookstore_app/modules/order/view/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  final String userId;
  final String? orderId; // optional — if present, show detail screen

  const OrderPage({super.key, required this.userId, this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersBloc>(
      create: (_) => OrdersBloc(),
      child:
          orderId == null
              ? OrdersScreen(userId: userId)
              : OrderDetailsScreen(orderId: orderId!),
    );
  }
}
