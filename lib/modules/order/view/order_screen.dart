import 'package:bookstore_app/modules/order/controller/order_controller.dart';
import 'package:bookstore_app/modules/order/bloc/orders_bloc.dart';
import 'package:bookstore_app/modules/order/view/widgets/order_card.dart';
import 'package:bookstore_app/modules/order/view/widgets/orders_empty_state.dart';
import 'package:bookstore_app/modules/products/view/widgets/app_drawer.dart';
import 'package:bookstore_app/modules/products/view/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatefulWidget {
  final String userId;
  const OrdersScreen({super.key, required this.userId});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final OrdersController _controller;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = OrdersController(bloc: BlocProvider.of<OrdersBloc>(context));
    _controller.loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        isSearching: _isSearching,
        controller: _controller,
        onToggleSearch: () {
          setState(() => _isSearching = !_isSearching);
          if (!_isSearching) _controller.onClearSearch();
        },
        onFilterSortPressed: () {},
      ),
      drawer: AppDrawer(onLogout: () => _controller.logout(context)),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersStateLoaded) {
            if (state.orders.isEmpty) return const OrdersEmptyState();
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (_, index) => OrderCard(order: state.orders[index]),
            );
          } else if (state is OrdersStateError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
