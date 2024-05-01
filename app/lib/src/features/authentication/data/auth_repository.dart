import 'package:irrigazione_iot/src/features/authentication/data/supabase_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/authentication/model/app_user.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  );

  /// Sign in using Google
  Future<void> signInWithGoogle();

  /// Signs user out
  Future<void> signOut();

  /// Reset password
  Future<void> resetPassword(
    String email,
    String newPassword,
  ) async {}

  // Sign up an AppUser and returns the user if successful
  Future<AppUser?> signUp({
    required AppUser appUser,
    required String password,
  });

  /// Emits the current user
  Stream<AuthState?> authStateChanges();

  /// Get the current user
  AppUser? get currentUser;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return SupabaseAuthRepository(Supabase.instance.client.auth);
}

// * Using keepAlive since other providers need to listen to this provider
@Riverpod(keepAlive: true)
Stream<AuthState?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
