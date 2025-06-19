// lib/modules/auth/controller/signup_controller.dart
import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/core/validation/form_validation.dart';
import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);
  final ValueNotifier<bool> confirmPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> isTermsAgreed = ValueNotifier(false);

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordVisible.dispose();
    confirmPasswordVisible.dispose();
    isTermsAgreed.dispose();
  }

  /// --- Visibility toggles ---
  void togglePasswordVisibility() =>
      passwordVisible.value = !passwordVisible.value;

  void toggleConfirmPasswordVisibility() =>
      confirmPasswordVisible.value = !confirmPasswordVisible.value;

  void toggleTermsAgreement() =>
      isTermsAgreed.value = !isTermsAgreed.value;

  /// --- Validators ---
  String? validateEmail(String? value) => FormValidator.email(value);
  String? validatePassword(String? value) => FormValidator.password(value);

  String? validateConfirmPassword(String? value) =>
      FormValidator.confirmPassword(
        passwordController.text.trim(),
        value?.trim(),
      );

  /// --- Logic ---
  Future<void> signup(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);
    final confirmError = validateConfirmPassword(confirm);

    if (emailError != null ||
        passwordError != null ||
        confirmError != null) {
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
