import 'package:bookstore_app/modules/products/view/widgets/app_drawer.dart';
import 'package:bookstore_app/modules/products/view/widgets/product_card.dart';
import 'package:bookstore_app/modules/products/view/widgets/search_app_bar.dart';
import 'package:bookstore_app/modules/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore_app/modules/wishlist/bloc/wishlist_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late final WishlistController _controller;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = WishlistController(context: context);
    _controller.loadWishlist();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        onFilterSortPressed: () {
          _controller.onFilterSortPressed(context, () => setState(() {}));
        },
      ),
      drawer: AppDrawer(onLogout: () => _controller.logout(context)),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistStateLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(
                child: Text('Explore more and build your wishlist'),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onAddToCart: () => _controller.addToCart(product),
                );
              },
            );
          } else if (state is WishlistStateError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
