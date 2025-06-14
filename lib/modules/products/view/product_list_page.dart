import 'package:bookstore_app/modules/products/bloc/product_bloc.dart';
import 'package:bookstore_app/modules/products/view/product_list_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc(),
      child: const ProductListScreen(),
    );
  }
}
