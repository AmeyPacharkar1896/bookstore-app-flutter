import 'package:bookstore_app/modules/account/view/account_screen.dart';
import 'package:bookstore_app/modules/admin/view/admin_dashboard.dart';
import 'package:bookstore_app/modules/auth/view/signup_screen.dart';
import 'package:bookstore_app/modules/cart/view/cart_screen.dart';
import 'package:bookstore_app/modules/category/view/category_screen.dart';
import 'package:bookstore_app/modules/order/view/order_page.dart';
import 'package:bookstore_app/modules/products/view/product_list_page.dart';
import 'package:bookstore_app/modules/wishlist/view/wishlist_page.dart';
import 'package:go_router/go_router.dart';
import 'package:bookstore_app/modules/auth/view/login_screen.dart';
import 'package:bookstore_app/modules/auth/view/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
    GoRoute(
      path: '/home',
      builder: (context, state) => const ProductListPage(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboard(),
    ),

    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final productId = state.pathParameters['id'];
        return ProductListPage(productId: productId!);
      },
    ),

    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartScreen(),
    ),

    GoRoute(
      path: '/wishlist',
      builder: (context, state) => const WishlistPage(),
    ),

    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoryScreen(),
    ),

    GoRoute(
      path: '/orders',
      builder: (context, state) {
        final userId = Supabase.instance.client.auth.currentUser!.id;
        return OrderPage(userId: userId);
      },
    ),
    GoRoute(
      path: '/orders/:id',
      builder: (context, state) {
        final userId = Supabase.instance.client.auth.currentUser!.id;
        final orderId = state.pathParameters['id']!;
        return OrderPage(userId: userId, orderId: orderId);
      },
    ),

    GoRoute(
      path: '/account',
      builder: (context, state) => const AccountScreen(),
    ),
  ],
);
