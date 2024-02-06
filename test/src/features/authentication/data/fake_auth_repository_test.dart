import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/authentication/data/fake_app_user.dart';
import 'package:irrigazione_iot/src/features/authentication/data/fake_auth_repository.dart';
import 'package:irrigazione_iot/src/utils/gen_fake_uuid.dart';

void main() {
  final testUserFromList = kFakeUsers[0];
  final testUser = FakeAppUser(
      uid: genFakeUuid('testuser@example.com'),
      email: 'testuser@example.com',
      name: 'Test',
      companyId: 6,
      role: AppUserRoles.user,
      surname: 'User',
      password: 'password');
  FakeAuthRepository makeAuthRepository() =>
      FakeAuthRepository(addDelay: false);
  group(
    "FakeAuthRepository",
    () {
      test('currentUser is null', () {
        final authRepository = makeAuthRepository();
        addTearDown(authRepository.dispose);
        // Check that current user is null
        expect(authRepository.currentUser, null);
        // Check that the authStateChanges stream emits null
        expect(authRepository.authStateChanges(), emits(null));
      });
    },
  );
}
