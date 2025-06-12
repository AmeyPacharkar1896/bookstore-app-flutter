import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:bookstore_app/core/utils/snackbar_helper.dart';

class SignupController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);
  final ValueNotifier<bool> confirmPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> isTermsAgreed = ValueNotifier(false); // ✅ Add this

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordVisible.dispose();
    confirmPasswordVisible.dispose();
    isTermsAgreed.dispose(); // ✅ Dispose this
  }

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  void toggleTermsAgreement() {
    isTermsAgreed.value = !isTermsAgreed.value; // ✅ Optional helper
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) return 'Invalid email format';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Minimum 8 characters required';
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
      return 'Must be alphanumeric';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  Future<void> signup(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);
    final confirmError = validateConfirmPassword(confirmPassword);

    if (emailError != null || passwordError != null || confirmError != null) {
      showSnackBar(
        context,
        message: emailError ?? passwordError ?? confirmError!,
        type: SnackbarType.error,
      );
      return;
    }

    if (!isTermsAgreed.value) {
      showSnackBar(
        context,
        message: 'You must agree to the terms and conditions',
        type: SnackbarType.warning,
      );
      return;
    }

    context.read<AuthBloc>().add(
      AuthEventSignUpWithEmail(email: email, password: password),
    );
  }

  void googleLogin(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventSignInWithGoogle());
  }
}
