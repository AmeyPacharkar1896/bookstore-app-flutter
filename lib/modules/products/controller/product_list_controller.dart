import 'dart:async';

import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:bookstore_app/modules/products/view/widgets/filter_sort_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore_app/modules/products/bloc/product_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductListController {
  final BuildContext context;
  final TextEditingController searchController = TextEditingController();
  Timer? _searchDebounce;

  String? selectedCategory;
  String? activeSort;
  String? activeType;
  bool ascending = true;

  ProductListController({required this.context}) {
    fetchAll();
  }

  void fetchAll() {
    context.read<ProductBloc>().add(ProductEventFetchAllProducts());
  }

  void onCategorySelected(String category, VoidCallback onUpdate) {
    selectedCategory = category;
    onUpdate();
    context.read<ProductBloc>().add(
      ProductEventFilterByCategory(category: category),
    );
  }

  void onSearchChanged(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      if (query.trim().isNotEmpty) {
        context.read<ProductBloc>().add(
          ProductEventSearch(query: query.trim()),
        );
      } else {
        fetchAll();
      }
    });
  }

  void onClearSearch() {
    searchController.clear();
    fetchAll();
  }

  Future<void> onFilterSortPressed(
    BuildContext context,
    VoidCallback onUpdate,
  ) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => FilterSortSheet(
            initialSortBy: activeSort,
            initialAscending: ascending,
            initialType: activeType,
          ),
    );

    if (result != null) {
      activeSort = result['sortBy'] as String?;
      activeType = result['type'] as String?;
      ascending = result['ascending'] as bool? ?? true;

      final bloc = context.read<ProductBloc>();
      if (activeType != null) {
        bloc.add(ProductEventFilterByType(productType: activeType!));
      }

      if (activeSort != null) {
        bloc.add(ProductEventSortBy(sortBy: activeSort!, ascending: ascending));
      }

      if (activeSort == null && activeType == null) {
        fetchAll();
      }

      onUpdate(); // To update UI chips if needed
    }
  }

  void logout(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventSignOut());
    context.go('/login');
  }

  void dispose() {
    searchController.dispose();
    _searchDebounce?.cancel();
  }
}
