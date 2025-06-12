import 'package:flutter/material.dart';

class TermsCheckbox extends StatelessWidget {
  final ValueNotifier<bool> isChecked;
  final VoidCallback onToggle;

  const TermsCheckbox({
    super.key,
    required this.isChecked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurface;

    return ValueListenableBuilder<bool>(
      valueListenable: isChecked,
      builder:
          (context, agreed, _) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            value: agreed,
            onChanged: (_) => onToggle(),
            title: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium?.copyWith(color: color),
                children: const [
                  TextSpan(text: "I agree to the "),
                  TextSpan(
                    text: "Terms of Service",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
