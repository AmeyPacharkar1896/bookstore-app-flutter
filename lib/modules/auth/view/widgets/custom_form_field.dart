import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String)? onFieldSubmitted;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
