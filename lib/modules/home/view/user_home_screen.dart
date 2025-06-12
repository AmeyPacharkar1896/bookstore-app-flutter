import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventSignOut());
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: const Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}
