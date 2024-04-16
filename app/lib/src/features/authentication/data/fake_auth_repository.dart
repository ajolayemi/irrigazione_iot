import 'dart:math';

import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/exceptions/app_exception.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/data/fake_app_user.dart';
import 'package:irrigazione_iot/src/features/authentication/model/app_user.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/gen_fake_uuid.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.addDelay = true});
  final bool addDelay;

  // In-memory store to hold the current user, it's initial value is null
  final _authUser = InMemoryStore<AppUser?>(null);

  final _authState = InMemoryStore<AuthState>(
    AuthState(
      AuthChangeEvent.initialSession,
      null,
    ),
  );

  @override
  Stream<AuthState> authStateChanges() => _authState.stream;

  @override
  AppUser? get currentUser => _authUser.value;

  // List to keep track of all user accounts
  final List<FakeAppUser> _users = kFakeUsers;

  @override
  Future<void> signOut() async {
    _authUser.value = null;
    _authState.value = AuthState(AuthChangeEvent.signedOut, null);
  }

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    await delay(addDelay);

    // check if their is a user with the provided email address
    final userIndexInList = _users.indexWhere((user) => user.email == email);

    // If no user matching the provided email address is found, throw an error
    if (userIndexInList == -1) {
      throw UserNotFoundException();
    }

    FakeAppUser? fakeUser = _users[userIndexInList];

    // If a user is found, update the password
    // but first check if the new password is the same as the old password
    if (fakeUser.password == newPassword) {
      throw IdenticalPasswordException();
    }

    // then check if the new password respects the password policy
    if (newPassword.length < AppConstants.minPasswordLength) {
      throw PasswordTooShortException();
    }

    // if the new password is different from the old password and respects the password policy
    // update the password
    final updatedUser = fakeUser.copyWith(password: newPassword);
    _users[userIndexInList] = updatedUser;
    _authUser.value = updatedUser;
    _authState.value = AuthState(AuthChangeEvent.passwordRecovery, null);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);

    // check the given credentials against each registered user
    for (final user in _users) {
      if (user.email == email && user.password == password) {
        _authUser.value = user;
        _authState.value = AuthState(AuthChangeEvent.signedIn, null);
        return;
      }
    }
    // same email, wrong password
    throw UserNotFoundException();
  }

  /// For the sake of this implementation, we are using a random user from the list of fake users
  @override
  Future<void> signInWithGoogle() async {
    await delay(addDelay);
    _authUser.value =
        kFakeUsers[Random(kFakeUsers.length).nextInt(kFakeUsers.length)];
    _authState.value = AuthState(AuthChangeEvent.signedIn, null);
  }

  @override
  Future<AppUser?> signUp({
    required AppUser appUser,
    required String password,
  }) async {
    await delay(addDelay);
    // Check if the email is already in use
    if (_users.any((user) => user.email == appUser.email)) {
      throw EmailAlreadyInUseException();
    }

    // No other checks are performed here since the form validation should have already
    // checked for the validity of the email, password, and other fields
    final userToAdd = FakeAppUser(
      uid: genFakeUuid(appUser.email),
      email: appUser.email,
      name: appUser.name,
      surname: appUser.surname,
      password: password,
    );

    _users.add(userToAdd);
    return Future.value(userToAdd);
  }

  void dispose() => _authUser.close();
}
