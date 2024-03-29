import 'package:irrigazione_iot/src/features/authentication/data/fake_auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/model/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  );

  /// Emits the current user
  Stream<AppUser?> authStateChanges();

  /// Get the current user
  AppUser? get currentUser;
}

/// General auth repository provider
// TODO replace with a real implementation of either Firebase or Supabase
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return FakeAuthRepository();
}

// * Using keepAlive since other providers need to listen to this provider
@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
