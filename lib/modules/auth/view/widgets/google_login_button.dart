import 'package:flutter/material.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset('assets/images/google_logo.png', height: 24),
      label: const Text('Continue with Google'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        side: BorderSide(color: theme.dividerColor),
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
