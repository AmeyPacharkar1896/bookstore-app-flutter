import 'dart:async';

import 'package:bookstore_app/modules/auth/model/user_model.dart';
import 'package:bookstore_app/modules/auth/service/auth_service.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthStateInitial()) {
    on<AppStarted>(_onAppStarted);
    on<AuthEventSignInWithGoogle>(_onAuthEventSignInWithGoogle);
    on<AuthEventSignOut>(_onAuthEventSignOut);
    on<AuthEventSignInWithEmail>(_onAuthEventSignInWithEmail);
    on<AuthEventForgotPassword>(_onAuthEventForgotPassword);
    on<AuthEventSignUpWithEmail>(_onAuthEventSignUpWithEmail);
  }

  final _authService = AuthService();

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    print('🔁 AppStarted event received');
    emit(const AuthStateLoading());

    try {
      final user = await _authService.sessionValidation();
      print('📦 sessionValidation returned: $user');

      user.fold(
        (failure) {
          print('❌ sessionValidation failed: $failure');
          emit(AuthStateUnauthenticated());
        },
        (user) {
          print('✅ Authenticated user: ${user.email}');
          emit(AuthStateAuthenticated(user: user));
        },
      );
    } catch (e) {
      print('🔥 Exception in AppStarted: $e');
      emit(AuthStateError(message: e.toString()));
    }
  }

  Future<void> _onAuthEventSignInWithGoogle(
    AuthEventSignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    try {
      final result = await _authService.signInWithGoogle();

      final userResult = await result.fold<Future<Either<String, UserModel>>>((
        failure,
      ) async {
        emit(AuthStateError(message: failure));
        return Future.value(null);
      }, (_) => _authService.sessionValidation());

      if (userResult != null) {
        userResult.fold(
          (failure) => emit(AuthStateUnauthenticated()),
          (user) => emit(AuthStateAuthenticated(user: user)),
        );
      }
    } catch (e) {
      emit(AuthStateError(message: e.toString()));
    }
  }

  Future<void> _onAuthEventSignInWithEmail(
    AuthEventSignInWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    try {
      final result = await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      await result.fold(
        (failure) async {
          debugPrint('Login failed: $failure');
          if (!emit.isDone) emit(AuthStateError(message: failure));
        },
        (_) async {
          debugPrint('Login success, checking session...');
          final userResult = await _authService.sessionValidation();
          await userResult.fold(
            (failure) async {
              debugPrint('Session failed: $failure');
              if (!emit.isDone) emit(AuthStateUnauthenticated());
            },
            (user) async {
              debugPrint('Session success: ${user.toString()}');
              if (!emit.isDone) emit(AuthStateAuthenticated(user: user));
            },
          );
        },
      );
    } catch (e) {
      if (!emit.isDone) emit(AuthStateError(message: e.toString()));
    }
  }

  Future<void> _onAuthEventSignOut(
    AuthEventSignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    try {
      final result = await _authService.signOut();

      result.fold(
        (failure) => emit(AuthStateError(message: failure)),
        (_) => emit(const AuthStateUnauthenticated()),
      );
    } catch (e) {
      emit(AuthStateError(message: e.toString()));
    }
  }

  Future<void> _onAuthEventForgotPassword(
    AuthEventForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    try {
      final result = await _authService.sentPasswordResetEmail(
        email: event.email,
      );

      result.fold(
        (failure) => emit(AuthStateError(message: failure)),
        (_) => emit(const AuthStateForgotPasswordEmailSent()),
      );
    } catch (e) {
      emit(AuthStateError(message: e.toString()));
    }
  }

  Future<void> _onAuthEventSignUpWithEmail(
    AuthEventSignUpWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());

    try {
      final result = await _authService.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      await result.fold(
        (failure) async {
          if (!emit.isDone) emit(AuthStateError(message: failure));
        },
        (_) async {
          final userDataResult = await _authService.fetchUserData();
          await userDataResult.fold(
            (err) async {
              if (!emit.isDone) emit(AuthStateError(message: err));
            },
            (userModel) async {
              if (!emit.isDone) emit(AuthStateAuthenticated(user: userModel));
            },
          );
        },
      );
    } catch (e) {
      if (!emit.isDone) emit(AuthStateError(message: e.toString()));
    }
  }
}
