import 'package:bookstore_app/core/utils/snackbar_helper.dart';
import 'package:bookstore_app/modules/auth/bloc/auth_bloc.dart';
import 'package:bookstore_app/modules/auth/controller/login_controller.dart';
import 'package:bookstore_app/modules/auth/view/widgets/google_login_button.dart';
import 'package:bookstore_app/modules/auth/view/widgets/login_form.dart';
import 'package:bookstore_app/modules/auth/view/widgets/auth_redirect_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoginController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      await _controller.login(context);
    }
  }

  void _onForgotPassword() {
    _controller.forgetPassword(context);
  }

  void _onGoogleLogin() {
    _controller.googleLogin(context);
  }

  void _onSignUpRedirect() {
    _controller.signup(context);
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
        child: BlocListener<AuthBloc, AuthState>(
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
                message: 'Login successful!',
                type: SnackbarType.success,
              );
              context.go('/home');
            } else if (state is AuthStateForgotPasswordEmailSent) {
              showSnackBar(
                context,
                message: 'Password reset email sent.',
                type: SnackbarType.success,
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
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
                          'Welcome Back!',
                          style: textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Log in to your account',
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        LoginForm(
                          formKey: _formKey,
                          controller: _controller,
                          onForgotPassword: _onForgotPassword,
                          onLoginPressed: _onLoginPressed,
                        ),

                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                'Or login with',
                                style: textTheme.bodyMedium,
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 24),

                        GoogleLoginButton(onPressed: _onGoogleLogin),

                        const SizedBox(height: 32),

                        AuthRedirectPrompt(
                          prefixText: "Don't have an account?",
                          actionText: "Sign Up",
                          onPressed: _onSignUpRedirect,
                        ),
                      ],
                    ),
                  ),

                  // Show loading overlay when in loading state
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
      ),
    );
  }
}
