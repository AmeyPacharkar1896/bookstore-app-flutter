import 'package:bookstore_app/modules/auth/view/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const EmailField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      controller: controller,
      label: 'Email Address',
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: validator,
      prefixIcon: Icons.email_outlined,
    );
  }
}
