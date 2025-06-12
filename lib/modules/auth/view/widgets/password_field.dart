import 'package:bookstore_app/modules/auth/view/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> visibleNotifier;
  final VoidCallback onToggleVisibility;
  final String label;
  final String? Function(String?)? validator;
  final VoidCallback onSubmitted;

  const PasswordField({
    super.key,
    required this.controller,
    required this.visibleNotifier,
    required this.onToggleVisibility,
    required this.label,
    required this.validator,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: visibleNotifier,
      builder: (_, visible, __) {
        return CustomFormField(
          controller: controller,
          label: label,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: validator,
          prefixIcon: Icons.lock_outline,
          obscureText: !visible,
          suffixIcon: IconButton(
            icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
            onPressed: onToggleVisibility,
          ),
          onFieldSubmitted: (_) => onSubmitted(),
        );
      },
    );
  }
}
