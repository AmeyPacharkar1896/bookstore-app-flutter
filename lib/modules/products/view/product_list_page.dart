import 'package:bookstore_app/modules/products/bloc/product_bloc.dart';
import 'package:bookstore_app/modules/products/view/product_detail_screen.dart';
import 'package:bookstore_app/modules/products/view/product_list_screen.dart';
import 'package:bookstore_app/modules/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  final String? productId;
  const ProductListPage({super.key, this.productId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => WishlistBloc()),
      ],
      child:
          (productId == null)
              ? const ProductListScreen()
              : ProductDetailScreen(productId: productId!),
    );
  }
}
