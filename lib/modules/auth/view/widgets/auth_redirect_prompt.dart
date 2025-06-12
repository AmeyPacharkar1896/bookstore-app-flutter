import 'package:flutter/material.dart';

class AuthRedirectPrompt extends StatelessWidget {
  final String prefixText;
  final String actionText;
  final VoidCallback onPressed;

  const AuthRedirectPrompt({
    super.key,
    required this.prefixText,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prefixText, style: textTheme.bodyMedium),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            actionText,
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
