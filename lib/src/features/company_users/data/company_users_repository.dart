import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/fake_company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';

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
}

// TODO replace this with a real implementation of either Firebase or Supabase
@Riverpod(keepAlive: true)
CompanyUsersRepository userCompaniesRepository(UserCompaniesRepositoryRef ref) {
  return FakeUserCompaniesRepository();
}

@riverpod
Future<List<Company>> userCompaniesFuture(UserCompaniesFutureRef ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final user = authRepository.currentUser;
  if (user == null) {
    return Future.value([]);
  }
  final userCompaniesRepository = ref.watch(userCompaniesRepositoryProvider);
  final companyRepository = ref.watch(companyRepositoryProvider);
  final userCompanies =
      await userCompaniesRepository.fetchCompaniesAssociatedWithUser(email: user.email);
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
  final userCompaniesRepository = ref.watch(userCompaniesRepositoryProvider);
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
  final userCompaniesRepository = ref.watch(userCompaniesRepositoryProvider);
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
