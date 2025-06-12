import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/modules/auth/controller/singup_controller.dart';
import 'package:bookstore_app/modules/auth/view/widgets/auth_redirect_prompt.dart';
import 'package:bookstore_app/modules/auth/view/widgets/email_field.dart';
import 'package:bookstore_app/modules/auth/view/widgets/google_login_button.dart';
import 'package:bookstore_app/modules/auth/view/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final SignupController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignupController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCreateAccountPressed() async {
    if (_formKey.currentState!.validate()) {
      await _controller.signup(context);
    }
  }

  void _onGoogleSignUp() {
    _controller.googleLogin(context);
  }

  void _onLoginRedirect() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bookstore', style: textTheme.titleLarge),
        automaticallyImplyLeading: false,
        elevation: 1,
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateError) {
              showSnackBar(
                context,
                message: state.message,
                type: SnackbarType.error,
              );
            } else if (state is AuthStateAuthenticated) {
              showSnackBar(
                context,
                message: 'Account created successfully!',
                type: SnackbarType.success,
              );
              context.go('/home');
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 36,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Icon(
                          Icons.book_rounded,
                          size: 80,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Create Your Account",
                        style: textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            EmailField(
                              controller: _controller.emailController,
                              validator: _controller.validateEmail,
                            ),
                            const SizedBox(height: 16),
                            PasswordField(
                              controller: _controller.passwordController,
                              visibleNotifier: _controller.passwordVisible,
                              onToggleVisibility:
                                  _controller.togglePasswordVisibility,
                              label: "Password",
                              validator: _controller.validatePassword,
                              onSubmitted: () {},
                            ),
                            const SizedBox(height: 16),
                            PasswordField(
                              controller: _controller.confirmPasswordController,
                              visibleNotifier:
                                  _controller.confirmPasswordVisible,
                              onToggleVisibility:
                                  _controller.toggleConfirmPasswordVisibility,
                              label: "Confirm Password",
                              validator: _controller.validateConfirmPassword,
                              onSubmitted: () {},
                            ),
                            const SizedBox(height: 16),

                            ValueListenableBuilder<bool>(
                              valueListenable: _controller.isTermsAgreed,
                              builder:
                                  (context, agreed, _) => CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: agreed,
                                    onChanged:
                                        (_) =>
                                            _controller.toggleTermsAgreement(),
                                    title: RichText(
                                      text: TextSpan(
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colorScheme.onSurface,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: "I agree to the ",
                                          ),
                                          TextSpan(
                                            text: "Terms of Service",
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          const TextSpan(text: " and "),
                                          TextSpan(
                                            text: "Privacy Policy",
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _onCreateAccountPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                child: const Text("Create Account"),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Or sign up with",
                              style: textTheme.bodyMedium,
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: 24),

                      GoogleLoginButton(onPressed: _onGoogleSignUp),

                      const SizedBox(height: 32),

                      AuthRedirectPrompt(
                        prefixText: "Already have an account?",
                        actionText: "Log In",
                        onPressed: _onLoginRedirect,
                      ),
                    ],
                  ),
                ),

                if (state is AuthStateLoading)
                  Container(
                    color: Colors.black.withOpacity(0.4),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
