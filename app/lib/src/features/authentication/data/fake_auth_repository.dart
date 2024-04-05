import 'dart:math';

import '../../../config/mock/fake_users_list.dart';
import '../../../constants/app_constants.dart';
import '../../../exceptions/app_exception.dart';
import 'auth_repository.dart';
import 'fake_app_user.dart';
import '../model/app_user.dart';
import '../../../utils/delay.dart';
import '../../../utils/gen_fake_uuid.dart';
import '../../../utils/in_memory_store.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.addDelay = true});
  final bool addDelay;

  // In-memory store to hold the current user, it's initial value is null
  final _authState = InMemoryStore<AppUser?>(null);

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  AppUser? get currentUser => _authState.value;

  // List to keep track of all user accounts
  final List<FakeAppUser> _users = kFakeUsers;

  @override
  Future<void> signOut() async {
    _authState.value = null;
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
    _authState.value = updatedUser;
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);

    // check the given credentials against each registered user
    for (final user in _users) {
      if (user.email == email && user.password == password) {
        _authState.value = user;
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
    _authState.value =
        kFakeUsers[Random(kFakeUsers.length).nextInt(kFakeUsers.length)];
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

  void dispose() => _authState.close();
}