// lib/core/utils/form_validator.dart
class FormValidator {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.length < 8) return 'Minimum 8 characters required';
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
      return 'Must contain letters and numbers';
    }
    return null;
  }

  static String? confirmPassword(String? password, String? confirm) {
    if (confirm == null || confirm.trim().isEmpty) return 'Please confirm your password';
    if (password != confirm) return 'Passwords do not match';
    return null;
  }
}
