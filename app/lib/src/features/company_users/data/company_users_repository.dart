import '../../../config/enums/roles.dart';
import '../../authentication/data/auth_repository.dart';
import 'company_repository.dart';
import 'selected_company_repository.dart';
import '../model/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'fake_company_users_repository.dart';
import '../model/company_user.dart';

part 'company_users_repository.g.dart';

// A repository to manage the companies connected to a user
// When either Supabase or Firebase is implemented, the repository that will be connected
// to this class will access the table where the users associated with the companies are stored
abstract class CompanyUsersRepository {
  /// Emits a list of [CompanyUser] linked with the provided user email
  Stream<List<CompanyUser>> watchCompaniesAssociatedWithUser(
      {required String email});

  /// Fetches a list of [CompanyUser] linked with the provided user email
  Future<List<CompanyUser>> fetchCompaniesAssociatedWithUser({
    required String email,
  });

  /// Emits the [CompanyUserRoles] linked with the provided user email and company id
  Stream<CompanyUserRoles?> watchCompanyUserRole({
    required String email,
    required String companyId,
  });

  /// Fetches the [CompanyUserRoles] linked with the provided user email and company id
  Future<CompanyUserRoles?> fetchCompanyUserRole(
      {required String email, required String companyId});

  /// Fetches a list of user email addresses linked with the provided company id
  Future<List<CompanyUser?>> fetchUsersAssociatedWithCompany({
    required String companyId,
  });

  /// Emits a list of [CompanyUser]s linked with the provided company id if any
  Stream<List<CompanyUser?>> watchUsersAssociatedWithCompany({
    required String companyId,
  });

  /// Emits a [CompanyUser] linked with the provided user companyUserId
  Stream<CompanyUser?> watchCompanyUser({required String companyUserId});

  /// Fetches a [CompanyUser] linked with the provided user companyUserId
  Future<CompanyUser?> fetchCompanyUser({required String companyUserId});

  /// Emits a list of email addresses already associated with the provided company id
  Stream<List<String>> watchEmailsAssociatedWithCompany({
    required String companyId,
  });

  /// Adds a new [CompanyUser] to the database and returns the newly added [CompanyUser] if successful
  Future<CompanyUser?> addCompanyUser({required CompanyUser companyUser});

  /// Updates an existing [CompanyUser] in the database and returns the updated [CompanyUser] if successful
  Future<CompanyUser?> updateCompanyUser({required CompanyUser companyUser});

  /// Deletes a [CompanyUser] from the database and returns true if successful
  Future<bool> deleteCompanyUser(
      {required String companyUserId});
}

// TODO replace this with a real implementation of either Firebase or Supabase
@Riverpod(keepAlive: true)
CompanyUsersRepository companyUsersRepository(CompanyUsersRepositoryRef ref) {
  return FakeUserCompaniesRepository();
}

@riverpod
Future<List<Company>> userCompaniesFuture(UserCompaniesFutureRef ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final user = authRepository.currentUser;
  if (user == null) {
    return Future.value([]);
  }
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);
  final companyRepository = ref.watch(companyRepositoryProvider);
  final userCompanies = await userCompaniesRepository
      .fetchCompaniesAssociatedWithUser(email: user.email);
  final companies = <Company>[];
  for (final userCompany in userCompanies) {
    final company = await companyRepository.fetchCompany(userCompany.companyId);
    if (company != null) {
      companies.add(company);
    }
  }
  return companies;
}

@riverpod
Stream<List<Company>> userCompaniesStream(UserCompaniesStreamRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final user = authRepository.currentUser;
  if (user == null) {
    return Stream.value([]);
  }
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);
  final companyRepository = ref.watch(companyRepositoryProvider);
  return userCompaniesRepository
      .watchCompaniesAssociatedWithUser(email: user.email)
      .asyncMap((userCompanies) async {
    final companies = <Company>[];
    for (final userCompany in userCompanies) {
      final company =
          await companyRepository.fetchCompany(userCompany.companyId);
      if (company != null) {
        companies.add(company);
      }
    }
    return companies;
  });
}

@Riverpod(keepAlive: true)
Stream<CompanyUserRoles?> companyUserRole(CompanyUserRoleRef ref) {
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);
  final currentSelectedCompany = ref.watch(currentTappedCompanyProvider).value;
  final authRepository = ref.watch(authRepositoryProvider);
  final user = authRepository.currentUser;
  if (user == null || currentSelectedCompany == null) {
    return const Stream.empty();
  }
  return userCompaniesRepository.watchCompanyUserRole(
    email: user.email,
    companyId: currentSelectedCompany.id,
  );
}

@riverpod
Stream<List<CompanyUser?>> usersAssociatedWithCompanyStream(
    UsersAssociatedWithCompanyStreamRef ref) {
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);
  final currentSelectedCompany = ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompany == null) {
    return Stream.value([]);
  }
  return userCompaniesRepository.watchUsersAssociatedWithCompany(
    companyId: currentSelectedCompany.id,
  );
}

@riverpod
Stream<CompanyUser?> companyUserStream(CompanyUserStreamRef ref,
    {required String companyUserId}) {
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);

  return userCompaniesRepository.watchCompanyUser(companyUserId: companyUserId);
}


@riverpod
Stream<List<String>> emailsAssociatedWithCompanyStream(
    EmailsAssociatedWithCompanyStreamRef ref) {
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);
  final currentSelectedCompany = ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompany == null) {
    return Stream.value([]);
  }
  return userCompaniesRepository.watchEmailsAssociatedWithCompany(
    companyId: currentSelectedCompany.id,
  );
}