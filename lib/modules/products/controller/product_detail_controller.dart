import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/modules/cart/bloc/cart_bloc.dart';
import 'package:bookstore_app/modules/products/bloc/product_bloc.dart';
import 'package:bookstore_app/modules/products/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailController {
  final BuildContext context;

  ProductDetailController({required this.context});

  void fetchProduct(String id) {
    context.read<ProductBloc>().add(
      ProductEventFetchProductById(productId: id),
    );
  }

  void addToCart(ProductModel product) {
    try {
      context.read<CartBloc>().add(CartEventAdd(product: product));
      showSnackBar(
        context,
        message: 'Added to cart successfully!',
        type: SnackbarType.success,
      );
    } catch (e) {
      showSnackBar(
        context,
        message: 'Failed to add to cart.',
        type: SnackbarType.error,
      );
    }
  }

  void toggleWishList(String productId, bool isWished) {
    // TODO: Replace with WishlistBloc or service logic
    final message = isWished ? 'Removed from wishlist' : 'Added to wishlist';
    showSnackBar(context, message: message, type: SnackbarType.success);
  }
}
