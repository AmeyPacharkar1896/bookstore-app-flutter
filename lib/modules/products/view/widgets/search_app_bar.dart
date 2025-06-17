import 'package:bookstore_app/modules/cart/bloc/cart_bloc.dart';
import 'package:bookstore_app/modules/common/interfaces/search_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final SearchFilterController controller;
  final VoidCallback onToggleSearch;
  final VoidCallback onFilterSortPressed;

  const SearchAppBar({
    super.key,
    required this.isSearching,
    required this.controller,
    required this.onToggleSearch,
    required this.onFilterSortPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      leading: Builder(
        builder:
            (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
      ),
      title:
          isSearching
              ? TextField(
                controller: controller.searchController,
                autofocus: true,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  hintStyle: theme.textTheme.bodyMedium,
                  border: InputBorder.none,
                ),
                onChanged: controller.onSearchChanged,
              )
              : Text(controller.title),
      actions: [
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          onPressed: onToggleSearch,
        ),
        if (controller.showFilter)
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: onFilterSortPressed,
          ),
        if (controller.showCart)
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final itemCount = state.totalQuantity;

              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () => context.go('/cart'),
                  ),
                  if (itemCount > 0)
                    Positioned(
                      right: 1,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '$itemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
      ],
    );
  }
}
