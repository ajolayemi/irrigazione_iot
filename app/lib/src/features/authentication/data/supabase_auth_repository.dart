import 'package:gotrue/src/types/auth_state.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/data/supabase_app_user.dart';
import 'package:irrigazione_iot/src/features/authentication/model/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._authClient);

  final GoTrueClient _authClient;
  @override
  Stream<AuthState> authStateChanges() => _authClient.onAuthStateChange;

  @override
  AppUser? get currentUser => _convertUser(
        _authClient.currentSession?.user,
      );

  @override
  Future<void> resetPassword(String email, String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) =>
      _authClient.signInWithPassword(
        password: password,
        email: email,
      );

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() => _authClient.signOut();

  @override
  Future<AppUser?> signUp({
    required AppUser appUser,
    required String password,
  }) async {
    // TODO enable email redirection here
    final signUpResponse = await _authClient.signUp(
      email: appUser.email,
      password: password,
      data: {
        'name': appUser.name,
        'surname': appUser.surname,
      },
    );
    return _convertUser(signUpResponse.session?.user);
  }

  /// Helper method to convert a [User] to an [AppUser]
  AppUser? _convertUser(User? user) =>
      user != null ? SupabaseAppUser(user) : null;
}
