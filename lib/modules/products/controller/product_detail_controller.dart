import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/modules/cart/bloc/cart_bloc.dart';
import 'package:bookstore_app/modules/products/bloc/product_bloc.dart';
import 'package:bookstore_app/modules/products/model/product_model.dart';
import 'package:bookstore_app/modules/wishlist/service/wishlist_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailController {
  final BuildContext context;

  ProductDetailController({required this.context});

  final _wishlistService = WishlistService();

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

  Future<void> toggleWishList(String productId, bool isWished) async {
    try {
      if (isWished) {
        await _wishlistService.removeFromWishlist(productId);
      } else {
        await _wishlistService.addToWishlist(productId);
      }

      final message = isWished ? 'Removed from wishlist' : 'Added to wishlist';
      showSnackBar(context, message: message, type: SnackbarType.success);
    } catch (e) {
      showSnackBar(
        context,
        message: 'Failed to add/remove from wishlist',
        type: SnackbarType.error,
      );
    }
  }

  Future<bool> isWished(String productId) =>
      _wishlistService.isProductWished(productId);
}
