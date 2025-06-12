import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning }

void showSnackBar(
  BuildContext context, {
  required String message,
  SnackbarType type = SnackbarType.success,
}) {
  final color = switch (type) {
    SnackbarType.success => Colors.green,
    SnackbarType.error => Colors.red,
    SnackbarType.warning => Colors.orange,
  };

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ),
  );
}
