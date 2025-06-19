import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:bookstore_app/modules/order/bloc/orders_bloc.dart';
import 'package:bookstore_app/modules/order/view/widgets/order_item_tile.dart';
import 'package:bookstore_app/modules/order/view/widgets/order_summary_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(
      OrdersEventLoadDetails(orderId: widget.orderId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/orders'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Order Details'),
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersStateDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersStateDetailsLoaded) {
            final order = state.order;
            final items = state.items;
            final hasDigital = items.any((e) => e.productType == 'digital');
            final hasPhysical = items.any((e) => e.productType == 'physical');

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Order Summary Section
                        OrderSummarySection(order: order),

                        const SizedBox(height: 16),
                        Text('Items', style: AppTheme.sectionTitleStyle),
                        const SizedBox(height: 8),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          separatorBuilder:
                              (_, __) => Divider(color: AppTheme.lightMistGrey),
                          itemBuilder:
                              (context, index) =>
                                  OrderItemTile(item: items[index]),
                        ),

                        if (hasPhysical) ...[
                          const SizedBox(height: 24),
                          Text(
                            'Shipping Information',
                            style: AppTheme.sectionTitleStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Amey Pacharkar\n123 Flutter St\nMumbai, MH 400001\nIndia',
                            style: textTheme.bodyLarge,
                          ),
                        ],

                        const SizedBox(height: 24),
                        Text(
                          'Payment Method',
                          style: AppTheme.sectionTitleStyle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Credit Card ending in **** 1234',
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                /// Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (hasDigital &&
                          order.status.toLowerCase() == 'completed')
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.deepTeal,
                            foregroundColor: AppTheme.softPageWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.download),
                          label: const Text("Download Digital Books"),
                        ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.deepTeal,
                          side: const BorderSide(color: AppTheme.deepTeal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.support_agent_outlined),
                        label: const Text("Contact Support"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is OrdersStateError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: textTheme.bodyMedium?.copyWith(color: AppTheme.errorRed),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
