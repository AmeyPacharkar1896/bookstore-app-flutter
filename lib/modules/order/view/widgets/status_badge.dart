import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    switch (status) {
      case 'DELIVERED':
      case 'COMPLETED':
        bgColor = AppTheme.successGreen;
        break;
      case 'PENDING':
      case 'PROCESSING':
        bgColor = AppTheme.warmOchre;
        break;
      case 'CANCELLED':
        bgColor = AppTheme.errorRed;
        break;
      default:
        bgColor = AppTheme.dustyGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.softPageWhite,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
