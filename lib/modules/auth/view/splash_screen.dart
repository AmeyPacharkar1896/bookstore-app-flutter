import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasRedirected = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    // ... inside your build method
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          // The guard clause is still important to prevent multiple navigations
          // for regular users or error states.
          if (_hasRedirected) return;

          if (state is AuthStateAuthenticated) {
            // --- ADMIN WORKFLOW ---
            if (state.user.role.toLowerCase() == 'admin') {
              // 1. Lock the listener to prevent other actions.
              _hasRedirected = true;

              // 2. Launch the external URL and wait for the result.
              final adminUrl = Uri.parse(
                'https://bookstore-admin-jvs6.onrender.com',
              );
              final success = await launchUrl(
                adminUrl,
                mode: LaunchMode.externalApplication,
              );

              // 3. Handle failure to launch.
              if (!success && mounted) {
                showSnackBar(
                  context,
                  message: "Could not open admin panel. Please try again.",
                  type: SnackbarType.error,
                );
                // Even on failure, log them out and send to login.
                context.read<AuthBloc>().add(AuthEventSignOut());
                context.go('/login');
                return;
              }

              // 4. The Fix: On success, immediately dispatch sign-out AND navigate.
              // The sign-out can complete in the background while the user
              // is already on the login screen.
              if (mounted) {
                context.read<AuthBloc>().add(AuthEventSignOut());
                context.go('/login');
              }

              // We're done with the admin flow, so we exit.
              return;
            }
            // --- REGULAR USER WORKFLOW ---
            else {
              _hasRedirected = true;
              context.go('/home');
            }
          } else if (state is AuthStateUnauthenticated) {
            _hasRedirected = true;
            context.go('/login');
          } else if (state is AuthStateError) {
            _hasRedirected = true;
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
