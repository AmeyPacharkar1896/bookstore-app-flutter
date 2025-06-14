import 'package:bookstore_app/modules/products/controller/product_list_controller.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final ProductListController controller;
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
              : const Text('Bookstore'),
      actions: [
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          onPressed: onToggleSearch,
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: onFilterSortPressed,
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {}, // Placeholder for cart navigation
        ),
      ],
    );
  }
}
