import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateAuthenticated) {
            if (state.user.role.toLowerCase() == 'admin') {
              context.go('/admin');
            } else {
              context.go('/home');
            }
          } else if (state is AuthStateUnauthenticated) {
            context.go('/login');
          } else if (state is AuthStateError) {
            showSnackBar(
              context,
              message: state.message,
              type: SnackbarType.error,
            );
            context.go('/login');
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
