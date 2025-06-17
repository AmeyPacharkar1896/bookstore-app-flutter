import 'package:bookstore_app/modules/wishlist/bloc/wishlist_bloc.dart';
import 'package:bookstore_app/modules/wishlist/view/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WishlistBloc>(
      create: (_) => WishlistBloc(),
      child: WishlistScreen(),
    );
  }
}
