import 'package:bookstore_app/core/utils/snackbar_helper.dart';
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

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

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
