import 'package:flutter/material.dart';
import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const AppDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppTheme.deepTeal),
            child: const Text(
              'Bookstore Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => context.go('/home'),
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Wishlist'),
            onTap: () => context.go('/wishlist'),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () => context.go('/categories'),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Orders'),
            onTap: () => context.go('/orders'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account'),
            onTap: () => context.go('/account'),
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              onLogout();
            },
          ),
        ],
      ),
    );
  }
}
