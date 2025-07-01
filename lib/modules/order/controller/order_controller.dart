import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:bookstore_app/modules/common/interfaces/search_filter_controller.dart';
import 'package:bookstore_app/modules/order/bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrdersController extends SearchFilterController {
  final OrdersBloc bloc;

  OrdersController({required this.bloc});

  @override
  final TextEditingController searchController = TextEditingController();

  @override
  String get title => 'My Orders';

  @override
  bool get showFilter => false;

  @override
  bool get showCart => false;

  @override
  void onSearchChanged(String query) {
    // Optional: Implement filtering logic if needed
    // Example: bloc.add(OrdersEventSearch(query));
  }

  @override
  void onClearSearch() {
    searchController.clear();
    onSearchChanged('');
  }

  @override
  Future<void> onFilterSortPressed(
    BuildContext context,
    VoidCallback onUpdate,
  ) async {
    // Not used for OrdersScreen, but must be implemented.
    // Just show a dialog or snackbar for now if triggered accidentally.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sorting and filtering not available on orders.'),
      ),
    );
  }

  void loadOrders() {
    bloc.add(OrdersEventLoad());
  }

  void loadOrderDetails(String orderId) {
    bloc.add(OrdersEventLoadDetails(orderId: orderId));
  }

  void logout(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventSignOut());
    context.go('/login');
  }

  @override
  void dispose() {
    searchController.dispose();
  }
}
