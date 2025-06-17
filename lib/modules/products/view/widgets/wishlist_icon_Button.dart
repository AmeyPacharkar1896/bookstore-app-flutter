import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:bookstore_app/modules/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistIconButton extends StatelessWidget {
  final String productId;
  const WishlistIconButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, state) {
        bool isWished = false;

        if (state is WishlistStateLoaded) {
          isWished = state.products.any((product) => product.id == productId);
        }

        return OutlinedButton(
          onPressed: () {
            context.read<WishlistBloc>().add(
              WishlistEventToggle(productId: productId),
            );
          },
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            side: BorderSide(
              color: isWished ? Colors.red : AppTheme.inkBlack.withOpacity(0.2),
            ),
            padding: const EdgeInsets.all(12),
          ),
          child: Icon(
            isWished ? Icons.favorite : Icons.favorite_border,
            color: isWished ? Colors.red : null,
          ),
        );
      },
    );
  }
}
