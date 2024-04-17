import 'package:google_sign_in/google_sign_in.dart';
import 'package:irrigazione_iot/env/env.dart';
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
  Future<void> signInWithGoogle() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    final webClientId = Env.webClientId;

    /// iOS Client ID that you registered with Google Cloud.
    final iosClientId = Env.iosClientId;

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await _authClient.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
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
