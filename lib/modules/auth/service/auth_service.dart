import 'dart:developer';
import 'dart:io';
import 'package:bookstore_app/core/constrants/db_tables.dart';
import 'package:bookstore_app/modules/auth/model/user_model.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supaBase = Supabase.instance.client;
  UserModel? _cachedUser;

  User? get currentUser => _supaBase.auth.currentUser;
  UserModel? get currentUserModel => _cachedUser;
  bool get isAdmin => _cachedUser?.role == 'admin';

  /// Validate session and get user data
  Future<Either<String, UserModel>> sessionValidation() async {
    try {
      final authUser = _supaBase.auth.currentUser;
      if (authUser != null) {
        final response =
            await _supaBase
                .from(DbTables.users)
                .select()
                .eq('id', authUser.id)
                .maybeSingle();

        if (response != null) {
          final user = UserModel.fromJson(response);
          _cachedUser = user;
          return Right(user);
        } else {
          // User doesn't exist in "users" table yet – create it
          final newUser = {
            'id': authUser.id,
            'email': authUser.email,
            'role': 'customer',
          };
          await _supaBase.from(DbTables.users).insert(newUser);
          final user = UserModel.fromJson(newUser);
          _cachedUser = user;
          return Right(user);
        }
      } else {
        return const Left('No active session found. Please log in.');
      }
    } catch (e) {
      log('Error during session validation: $e');
      return const Left('Unable to validate session. Please try again later.');
    }
  }

  /// Fetch logged-in user data
  Future<Either<String, UserModel>> fetchUserData() async {
    try {
      final user = _supaBase.auth.currentUser;
      if (user == null) {
        return Left('No logged-in user found. Please log in.');
      }

      final response =
          await _supaBase
              .from(DbTables.users)
              .select()
              .eq('id', user.id)
              .maybeSingle();

      if (response != null) {
        final model = UserModel.fromJson(response);
        _cachedUser = model;
        return Right(model);
      } else {
        return const Left('User not found in the database.');
      }
    } catch (e) {
      log('Error fetching user data: $e');
      return const Left(
        'Failed to retrieve user data. Please try again later.',
      );
    }
  }

  Future<Either<String, void>> signInWithGoogle() async {
    try {
      final redirectUri =
          Platform.isAndroid
              ? 'com.example.bookstore_app://login-callback'
              : 'http://localhost:3000/login-callback';

      log('Initiating Google sign-in. Redirect: $redirectUri');

      await _supaBase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: redirectUri,
      );

      log('User signed in with Google successfully');
      return const Right(null);
    } catch (e) {
      log('Error during Google sign-in: $e');
      return const Left('Google sign-in failed. Please try again.');
    }
  }

  /// Sign in with email and password
  Future<Either<String, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supaBase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final session = response.session;
      final user = response.user;
      if (session != null && user != null) {
        log('User signed in successfully: ${user.email}');
        return Right(null);
      } else {
        return const Left('Sign-in failed. Please check your credentials.');
      }
    } catch (e) {
      log('Error during email/password sign-in: $e');
      return const Left(
        'Sign-in failed. Please check your email and password.',
      );
    }
  }

  /// Sign up with email and password
  Future<Either<String, void>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supaBase.auth.signUp(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user != null) {
        log('User signed up successfully: ${user.email}');
        await _supaBase.from(DbTables.users).insert({
          'id': user.id,
          'email': user.email,
          'role': 'customer',
        });
        return Right(null); // Success with no data
      } else {
        return const Left('Sign-up failed. Please try again.');
      }
    } catch (e) {
      log('Error during email/password sign-up: $e');
      return const Left(
        'Sign-up failed. Please check your details and try again.',
      );
    }
  }

  /// Sign out the user
  Future<Either<String, void>> signOut() async {
    try {
      _cachedUser = null;
      await _supaBase.auth.signOut();
      return const Right(null); // Success with no data
    } catch (e) {
      log('Error during sign-out: $e');
      return const Left('Unable to sign out. Please try again.');
    }
  }

  /// Send password reset email
  Future<Either<String, void>> sentPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _supaBase.auth.resetPasswordForEmail(email);
      log('Password reset email sent successfully to $email');
      return const Right(null); // Success with no data
    } catch (e) {
      log('Error during password reset: $e');
      return const Left(
        'Failed to send password reset email. Please try again.',
      );
    }
  }
}
