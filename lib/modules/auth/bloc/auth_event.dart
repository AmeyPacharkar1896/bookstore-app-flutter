part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  const AppStarted();

  @override
  List<Object> get props => [];
}

class AuthEventSignInWithGoogle extends AuthEvent {
  const AuthEventSignInWithGoogle();

  @override
  List<Object> get props => [];
}

class AuthEventSignInWithEmail extends AuthEvent {
  final String email;
  final String password;

  const AuthEventSignInWithEmail({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthEventSignOut extends AuthEvent {
  const AuthEventSignOut();

  @override
  List<Object> get props => [];
}

class AuthEventForgotPassword extends AuthEvent {
  final String email;

  const AuthEventForgotPassword({required this.email});

  @override
  List<Object> get props => [email];
}

class AuthEventSignUpWithEmail extends AuthEvent {
  final String email;
  final String password;

  const AuthEventSignUpWithEmail({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
