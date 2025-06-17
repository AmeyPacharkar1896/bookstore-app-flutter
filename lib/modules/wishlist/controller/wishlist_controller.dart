import 'dart:async';
import 'package:bookstore_app/modules/common/interfaces/search_filter_controller.dart';
import 'package:bookstore_app/modules/wishlist/bloc/wishlist_bloc.dart';
import 'package:bookstore_app/modules/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistController implements SearchFilterController {
  final BuildContext context;
  final TextEditingController searchController = TextEditingController();
  Timer? _searchDebounce;

  WishlistController({required this.context});

  void loadWishlist() {
    context.read<WishlistBloc>().add(WishlistEventLoad());
  }

  @override
  String get title => 'Wishlist';

  @override
  bool get showFilter => false;

  @override
  bool get showCart => false;

  void addToCart(product) {
    context.read<CartBloc>().add(CartEventAdd(product: product));
  }

  @override
  void onSearchChanged(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      if (query.trim().isNotEmpty) {
        context.read<WishlistBloc>().add(
          WishlistEventSearch(query: query.trim()),
        );
      } else {
        context.read<WishlistBloc>().add(WishlistEventLoad());
      }
    });
  }

  @override
  void onClearSearch() {
    searchController.clear();
    loadWishlist();
  }

  @override
  Future<void> onFilterSortPressed(
    BuildContext context,
    VoidCallback onUpdate,
  ) async {
    // Optional: implement filtering/sorting for wishlist if needed
  }

  void dispose() {
    searchController.dispose();
    _searchDebounce?.cancel();
  }
}
