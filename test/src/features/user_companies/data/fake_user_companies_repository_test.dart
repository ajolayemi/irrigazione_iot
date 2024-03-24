import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/authentication/data/fake_app_user.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/fake_user_companies_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company_user.dart';
import 'package:irrigazione_iot/src/utils/gen_fake_uuid.dart';

void main() {
  final testUserWithAssociatedCompanies = kFakeUsers.first;
  final associatedCompanies = [
    CompanyUser(
      appUser: kFakeUsers[0],
      companyId: '1',
      role: CompanyUserRoles.admin,
    ),
    CompanyUser(
      appUser: kFakeUsers[0],
      companyId: '2',
      role: CompanyUserRoles.user,
    ),
  ];
  final testUserWithoutAssociatedCompanies = FakeAppUser(
      uid: genFakeUuid('fake@fake.com'),
      email: 'fake@fake.com',
      name: 'Fake',
      surname: 'User',
      password: 'fakeuser123');

  FakeUserCompaniesRepository makeUserCompaniesRepository() =>
      FakeUserCompaniesRepository();

  group('FakeUserCompaniesRepository - with valid user', () {
    test('watchCompaniesAssociatedWithUser emits valid companies', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final res = repo.watchCompaniesAssociatedWithUser(
          testUserWithAssociatedCompanies.uid);
      expect(res, emits(associatedCompanies));
    });

    test('fetchCompaniesAssociateWithUser returns valid companies', () async {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final res = await repo.fetchCompaniesAssociatedWithUser(
          testUserWithAssociatedCompanies.uid);
      expect(res, associatedCompanies);
    });

    test('fetchCompanyUserRole returns a valid role', () async {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = await repo.fetchCompanyUserRole(
          testUserWithAssociatedCompanies.uid,
          associatedCompanies.first.companyId);
      final secondRole = await repo.fetchCompanyUserRole(
          testUserWithAssociatedCompanies.uid,
          associatedCompanies[1].companyId);

      expect(role, CompanyUserRoles.admin);
      expect(secondRole, CompanyUserRoles.user);
    });

    test('fetchCompanyUserRole with an invalid company returns null', () async {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = await repo.fetchCompanyUserRole(
          testUserWithAssociatedCompanies.uid, 'invalid_company_id');
      final secondRole = await repo.fetchCompanyUserRole(
          testUserWithAssociatedCompanies.uid, 'invalid_company_id');

      expect(role, isNull);
      expect(secondRole, isNull);
    });

    test('watchCompanyUserRole emits a valid role', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = repo.watchCompanyUserRole(
          testUserWithAssociatedCompanies.uid,
          associatedCompanies.first.companyId);
      final secondRole = repo.watchCompanyUserRole(
          testUserWithAssociatedCompanies.uid,
          associatedCompanies[1].companyId);

      expect(role, emits(CompanyUserRoles.admin));
      expect(secondRole, emits(CompanyUserRoles.user));
    });

    test('watchCompanyUserRole emits null with an invalid company id', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = repo.watchCompanyUserRole(
          testUserWithAssociatedCompanies.uid, 'invalid_company_id');
      final secondRole = repo.watchCompanyUserRole(
          testUserWithAssociatedCompanies.uid, 'invalid_company_id');

      expect(role, emits(isNull));
      expect(secondRole, emits(isNull));
    });
  });

  group('FakeUserCompaniesRepository - with invalid user', () {
    test('watchCompaniesAssociatedWithUser emits an empty list', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final res = repo.watchCompaniesAssociatedWithUser(
          testUserWithoutAssociatedCompanies.uid);
      expect(res, emits(isEmpty));
    });

    test('fetchCompaniesAssociateWithUser returns empty list', () async {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final res = await repo.fetchCompaniesAssociatedWithUser(
          testUserWithoutAssociatedCompanies.uid);
      expect(res, isEmpty);
    });

    test('fetchCompanyUserRole returns null', () async {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = await repo.fetchCompanyUserRole(
          testUserWithoutAssociatedCompanies.uid,
          associatedCompanies.first.companyId);
      final secondRole = await repo.fetchCompanyUserRole(
          testUserWithoutAssociatedCompanies.uid,
          associatedCompanies[1].companyId);

      expect(role, isNull);
      expect(secondRole, isNull);
    });

    test('watchCompanyUserRole emits null', () {
      final repo = makeUserCompaniesRepository();
      addTearDown(repo.dispose);
      final role = repo.watchCompanyUserRole(
          testUserWithoutAssociatedCompanies.uid,
          associatedCompanies.first.companyId);
      final secondRole = repo.watchCompanyUserRole(
          testUserWithoutAssociatedCompanies.uid,
          associatedCompanies[1].companyId);

      expect(role, emits(isNull));
      expect(secondRole, emits(isNull));
    });
  });
}
