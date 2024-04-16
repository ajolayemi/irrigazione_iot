import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/exceptions/app_exception.dart';
import 'package:irrigazione_iot/src/features/authentication/data/fake_app_user.dart';
import 'package:irrigazione_iot/src/features/authentication/data/fake_auth_repository.dart';
import 'package:irrigazione_iot/src/utils/gen_fake_uuid.dart';

void main() {
  final testUserFromList = kFakeUsers[0];
  final testUser = FakeAppUser(
      uid: genFakeUuid('testuser@example.com'),
      email: 'testuser@example.com',
      name: 'Test',
      surname: 'User',
      password: 'password');
  FakeAuthRepository makeAuthRepository() =>
      FakeAuthRepository(addDelay: false);
  group(
    'FakeAuthRepository - signIn and current user state tests',
    () {
      test('currentUser is null', () {
        final authRepository = makeAuthRepository();
        addTearDown(authRepository.dispose);
        // Check that current user is null
        expect(authRepository.currentUser, null);
        // Check that the authStateChanges stream emits null
        expect(authRepository.authStateChanges(), emits(null));
      });

      test('sign in throws error when user not found', () async {
        final authRepository = makeAuthRepository();
        addTearDown(authRepository.dispose);

        // expect sign in method to throw an error when an invalid user is passed
        await expectLater(
          () => authRepository.signInWithEmailAndPassword(
              testUser.email, testUser.password),
          throwsA(isA<UserNotFoundException>()),
        );

        // current user should also be null
        expect(authRepository.currentUser, null);
        // Check that the authStateChanges stream emits null
        expect(authRepository.authStateChanges(), emits(null));
      });

      test('user is not null after sign in', () async {
        final authRepository = makeAuthRepository();
        addTearDown(authRepository.dispose);
        // Sign user in
        await authRepository.signInWithEmailAndPassword(
          testUserFromList.email,
          testUserFromList.password,
        );

        // Check that current user is not null
        expect(authRepository.currentUser, testUserFromList);
        // Check that the authStateChanges stream emits the user
        expect(
          authRepository.authStateChanges(),
          emits(isNotNull),
        );
      });

      test('google signIn works', () async {
        final authRepository = makeAuthRepository();
        addTearDown(authRepository.dispose);
        await authRepository.signInWithGoogle();
        expect(authRepository.currentUser, isNotNull);
        expect(authRepository.authStateChanges(), emits(isNotNull));
      });

      test('signIn throws an error after dispose', () async {
        final authRepository = makeAuthRepository();
        addTearDown(authRepository.dispose);
        authRepository.dispose();
        await expectLater(
          () => authRepository.signInWithEmailAndPassword(
            testUserFromList.email,
            testUserFromList.password,
          ),
          throwsStateError,
        );
      });
    },
  );

  group('FakeAuthRepository - signOut test', () {
    test('user is null after signOut', () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      // Sign user in
      await authRepository.signInWithEmailAndPassword(
        testUserFromList.email,
        testUserFromList.password,
      );

      // Check that current user is not null
      expect(authRepository.currentUser, testUserFromList);
      // Check that the authStateChanges stream emits the user
      expect(
        authRepository.authStateChanges(),
        emits(isNotNull),
      );

      // Sign user out
      await authRepository.signOut();
      expect(authRepository.currentUser, null);
      // Check that the authStateChanges stream emits the user
      expect(
        authRepository.authStateChanges(),
        emits(null),
      );
    });
  });

  group('FakeAuthRepository - resetPassword tests', () {
    test('resetPassword throws error when user not found', () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      // expect resetPassword method to throw an error when an invalid user is passed
      await expectLater(
        () => authRepository.resetPassword(
          testUser.email,
          testUser.password,
        ),
        throwsA(isA<UserNotFoundException>()),
      );
      expect(authRepository.currentUser, null);
      expect(
        authRepository.authStateChanges(),
        emits(null),
      );
    });

    test(
        'resetPassword throws an error when user is found but same password is provided',
        () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      await expectLater(
        () => authRepository.resetPassword(
            testUserFromList.email, testUserFromList.password),
        throwsA(isA<IdenticalPasswordException>()),
      );
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });

    test(
        'resetPassword throws an error when user is found but password is short',
        () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      await expectLater(
        () => authRepository.resetPassword(testUserFromList.email, 'pass'),
        throwsA(
          isA<PasswordTooShortException>(),
        ),
      );
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });

    test('resetPassword successfully resets password', () async {
      final authRepository = makeAuthRepository();
      addTearDown(authRepository.dispose);
      await authRepository.resetPassword(
        testUserFromList.email,
        'newpassword',
      );
      final newUser = testUserFromList.copyWith(
        password: 'newpassword',
      );
      expect(
        authRepository.currentUser,
        newUser,
      );
      expect(authRepository.authStateChanges(), emits(isNotNull));
    });
  });
}
