import 'package:bookstore_app/modules/products/bloc/product_bloc.dart';
import 'package:bookstore_app/modules/products/controller/product_detail_controller.dart';
import 'package:bookstore_app/modules/products/controller/product_list_controller.dart';
import 'package:bookstore_app/modules/products/view/widgets/category_chip_row.dart';
import 'package:bookstore_app/modules/products/view/widgets/product_card.dart';
import 'package:bookstore_app/modules/products/view/widgets/product_drawer.dart';
import 'package:bookstore_app/modules/products/view/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductListController _productListController;
  late ProductDetailController _productDetailController;
  bool _isSearching = false;

  final List<String> categories = [
    'Fiction',
    'Non-Fiction',
    'Digital',
    'Physical',
    'Bestsellers',
  ];

  @override
  void initState() {
    super.initState();
    _productListController = ProductListController(context: context);
    _productDetailController = ProductDetailController(context: context);
  }

  @override
  void dispose() {
    _productListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        isSearching: _isSearching,
        controller: _productListController,
        onToggleSearch: () {
          setState(() => _isSearching = !_isSearching);
          if (!_isSearching) _productListController.onClearSearch();
        },
        onFilterSortPressed:
            () => _productListController.onFilterSortPressed(
              context,
              () => setState(() {}),
            ),
      ),
      drawer: ProductDrawer(
        onLogout: () => _productListController.logout(context),
      ),
      body: Column(
        children: [
          CategoryChipsRow(
            categories: categories,
            selectedCategory: _productListController.selectedCategory,
            onCategorySelected: (category) {
              _productListController.onCategorySelected(
                category,
                () => setState(() {}),
              );
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductStateError) {
                  return Center(child: Text(state.message));
                } else if (state is ProductStateLoaded) {
                  final products = state.products;
                  if (products.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }
                  return RefreshIndicator(
                    onRefresh: () async => _productListController.fetchAll(),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.65,
                          ),
                      itemCount: products.length,
                      itemBuilder:
                          (context, index) => ProductCard(
                            product: products[index],
                            onAddToCart:
                                () => _productDetailController.addToCart(
                                  products[index],
                                ),
                          ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
