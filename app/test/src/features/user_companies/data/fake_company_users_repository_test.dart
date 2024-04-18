import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/config/mock/fake_company_users.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/authentication/data/fake_app_user.dart';
import 'package:irrigazione_iot/src/features/company_users/data/fake_company_users_repository.dart';
import 'package:irrigazione_iot/src/utils/gen_fake_uuid.dart';

void main() {
  final testUserWithAssociatedCompanies = kFakeUsers.first;
  final associatedCompaniesId = kFakeCompanyUsers
      .where((user) => user.email == testUserWithAssociatedCompanies.email)
      .map((user) => user.companyId)
      .toList();
  final associatedCompanies = kFakeCompanies
      .where((company) => associatedCompaniesId.contains(company.id))
      .toList();
  final testUserWithoutAssociatedCompanies = FakeAppUser(
      uid: genFakeUuid('fake@fake.com'),
      email: 'fake@fake.com',
      name: 'Fake',
      surname: 'User',
      password: 'fakeuser123');

  FakeCompanyUsersRepository makeUserCompaniesRepository() =>
      FakeCompanyUsersRepository(addDelay: false);

  group('FakeUserCompaniesRepository - with valid user', () {
    test('watchCompaniesAssociatedWithUser emits valid companies', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final res = repo.watchCompaniesAssociatedWithUser(
          email: testUserWithAssociatedCompanies.email);
      expect(res, emits(associatedCompanies));
    });


    test('fetchCompanyUserRole returns a valid role', () async {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = await repo.fetchCompanyUserRole(
          email: testUserWithAssociatedCompanies.email,
          companyId: associatedCompanies.first.id);
      final secondRole = await repo.fetchCompanyUserRole(
          email: testUserWithAssociatedCompanies.email,
          companyId: associatedCompanies[1].id);

      expect(role, CompanyUserRoles.admin);
      expect(secondRole, CompanyUserRoles.user);
    });

    test('fetchCompanyUserRole with an invalid company returns null', () async {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = await repo.fetchCompanyUserRole(
          email: testUserWithAssociatedCompanies.email,
          companyId: 'invalid_company_id');
      final secondRole = await repo.fetchCompanyUserRole(
          email: testUserWithAssociatedCompanies.email,
          companyId: 'invalid_company_id');

      expect(role, isNull);
      expect(secondRole, isNull);
    });

    test('watchCompanyUserRole emits a valid role', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = repo.watchCompanyUserRole(
          email: testUserWithAssociatedCompanies.email,
          companyId: associatedCompanies.first.id);
      final secondRole = repo.watchCompanyUserRole(
          email: testUserWithAssociatedCompanies.email,
          companyId: associatedCompanies[1].id);

      expect(role, emits(CompanyUserRoles.admin));
      expect(secondRole, emits(CompanyUserRoles.user));
    });

    test('watchCompanyUserRole emits null with an invalid company id', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = repo.watchCompanyUserRole(
          email: testUserWithAssociatedCompanies.email,
          companyId: 'invalid_company_id');
      final secondRole = repo.watchCompanyUserRole(
          email: testUserWithAssociatedCompanies.email,
          companyId: 'invalid_company_id');

      expect(role, emits(isNull));
      expect(secondRole, emits(isNull));
    });
  });

  group('FakeUserCompaniesRepository - with invalid user', () {
    test('watchCompaniesAssociatedWithUser emits an empty list', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final res = repo.watchCompaniesAssociatedWithUser(
          email: testUserWithoutAssociatedCompanies.email);
      expect(res, emits(isEmpty));
    });

    test('fetchCompanyUserRole returns null', () async {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = await repo.fetchCompanyUserRole(
          email: testUserWithoutAssociatedCompanies.email,
          companyId: associatedCompanies.first.id);
      final secondRole = await repo.fetchCompanyUserRole(
          email: testUserWithoutAssociatedCompanies.uid,
          companyId: associatedCompanies[1].id);

      expect(role, isNull);
      expect(secondRole, isNull);
    });

    test('watchCompanyUserRole emits null', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = repo.watchCompanyUserRole(
          email: testUserWithoutAssociatedCompanies.uid,
          companyId: associatedCompanies.first.id);
      final secondRole = repo.watchCompanyUserRole(
          email: testUserWithoutAssociatedCompanies.uid,
          companyId: associatedCompanies[1].id);

      expect(role, emits(isNull));
      expect(secondRole, emits(isNull));
    });
  });
}
