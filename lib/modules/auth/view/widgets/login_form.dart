import 'package:bookstore_app/modules/auth/view/widgets/email_field.dart';
import 'package:bookstore_app/modules/auth/view/widgets/forgot_password_link.dart';
import 'package:bookstore_app/modules/auth/view/widgets/login_button.dart';
import 'package:bookstore_app/modules/auth/view/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:bookstore_app/modules/auth/controller/login_controller.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LoginController controller;
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPassword;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.onLoginPressed,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          EmailField(
            controller: controller.emailController,
            validator: controller.validateEmail,
          ),
          const SizedBox(height: 16),
          PasswordField(
            controller: controller.passwordController,
            visibleNotifier: controller.passwordVisible,
            onToggleVisibility: controller.togglePasswordVisibility,
            label: "Password",
            validator: controller.validatePassword,
            onSubmitted: onLoginPressed,
          ),
          const SizedBox(height: 8),
          ForgotPasswordLink(onPressed: onForgotPassword),
          const SizedBox(height: 8),
          LoginButton(onPressed: onLoginPressed),
        ],
      ),
    );
  }
}
