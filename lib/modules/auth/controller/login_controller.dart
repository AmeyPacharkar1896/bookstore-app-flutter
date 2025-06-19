// lib/modules/auth/controller/login_controller.dart
import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/core/validation/form_validation.dart';
import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordVisible.dispose();
  }

  void togglePasswordVisibility() =>
      passwordVisible.value = !passwordVisible.value;

  String? validateEmail(String? value) => FormValidator.email(value);
  String? validatePassword(String? value) => FormValidator.password(value);

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    if (emailError != null || passwordError != null) {
      showSnackBar(
        context,
        message: emailError ?? passwordError!,
        type: SnackbarType.error,
      );
      return;
    }

    context.read<AuthBloc>().add(
      AuthEventSignInWithEmail(email: email, password: password),
    );
  }

  void forgetPassword(BuildContext context) {
    final email = emailController.text.trim();
    final emailError = validateEmail(email);

    if (emailError != null) {
      showSnackBar(context, message: emailError, type: SnackbarType.error);
      return;
    }

    context.read<AuthBloc>().add(AuthEventForgotPassword(email: email));
  }

  void googleLogin(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventSignInWithGoogle());
  }

  void signup(BuildContext context) {
    context.go('/signup');
  }
}
