import 'package:irrigazione_iot/src/features/authentication/data/fake_auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/model/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> signInWithGoogle();

  Future<void> signOut();

  Future<void> resetPassword(String email, String newPassword);

  Stream<AppUser?> authStateChanges();

  AppUser? get currentUser;

  Stream<AppUser?> watchUserWithEmail(String email);
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


@riverpod
Stream<AppUser?> watchUserWithEmail(WatchUserWithEmailRef ref, String email) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.watchUserWithEmail(email);
}