import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:bookstore_app/modules/products/bloc/product_bloc.dart';
import 'package:bookstore_app/modules/products/controller/product_detail_controller.dart';
import 'package:bookstore_app/modules/products/view/widgets/wishlist_icon_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final ProductDetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProductDetailController(context: context);
    _controller.fetchProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Book Details'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductStateError) {
            return Center(
              child: Text(
                'Failed to load product.',
                style: textTheme.bodyLarge,
              ),
            );
          }

          if (state is ProductStateSingleLoaded) {
            final product = state.product;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                100,
              ), // extra bottom padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Cover Image
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.lightMistGrey,
                      image: DecorationImage(
                        image: NetworkImage(product.coverUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title & Author
                  Text(product.title, style: textTheme.displayLarge),
                  const SizedBox(height: 4),
                  Text('by ${product.author}', style: textTheme.bodyMedium),

                  const SizedBox(height: 12),

                  // Price and Format Tag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${product.price}',
                        style: textTheme.titleLarge?.copyWith(
                          color: AppTheme.deepTeal,
                        ),
                      ),
                      Chip(
                        label: Text(product.productType),
                        backgroundColor: AppTheme.lightMistGrey,
                        labelStyle: textTheme.bodyMedium?.copyWith(
                          color: AppTheme.inkBlack,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Text('Description', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? 'No description',
                    style: textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 24),

                  // Ratings & Reviews (if any)
                  // Text('Reviews', style: textTheme.titleMedium),
                  // const SizedBox(height: 12),
                  // for (final review in product.reviews)
                  //   _buildReviewCard(...),
                ],
              ),
            );
          }

          return const SizedBox.shrink(); // fallback
        },
      ),

      // ✅ Sticky Action Bar
      bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is! ProductStateSingleLoaded) {
            return const SizedBox.shrink();
          }
          final product = state.product;

          return SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  WishlistIconButton(productId: product.id),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _controller.addToCart(product),
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
