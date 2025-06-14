import 'package:bookstore_app/modules/admin/view/admin_dashboard.dart';
import 'package:bookstore_app/modules/auth/view/signup_screen.dart';
import 'package:bookstore_app/modules/products/view/product_list_page.dart';
import 'package:go_router/go_router.dart';
import 'package:bookstore_app/modules/auth/view/login_screen.dart';
import 'package:bookstore_app/modules/auth/view/splash_screen.dart';

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
  ],
);
