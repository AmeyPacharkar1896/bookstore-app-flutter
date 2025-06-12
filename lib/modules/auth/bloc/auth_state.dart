part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateAuthenticated extends AuthState {
  final UserModel user;

  const AuthStateAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

class AuthStateError extends AuthState {
  final String message;

  const AuthStateError({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthStateForgotPasswordEmailSent extends AuthState {
  const AuthStateForgotPasswordEmailSent();

  @override
  List<Object> get props => [];
}
