import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/user_companies/data/fake_user_companies_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/user_company.dart';

part 'user_companies_repository.g.dart';

// A repository to manage the companies connected to a user
// When either Supabase or Firebase is implemented, the repository that will be connected
// to this class will access the table where the users associated with the companies are stored
abstract class UserCompaniesRepository {
  Stream<List<UserCompany>> watchCompaniesAssociatedWithUser(String userId);
  Future<List<UserCompany>> fetchCompaniesAssociatedWithUser(String userId);
  Stream<CompanyUserRoles?> watchCompanyUserRole(
    String userId,
    String companyId,
  );
  Future<CompanyUserRoles?> fetchCompanyUserRole(
      String userId, String companyId);
}

// TODO replace this with a real implementation of either Firebase or Supabase
@Riverpod(keepAlive: true)
UserCompaniesRepository userCompaniesRepository(
    UserCompaniesRepositoryRef ref) {
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
      await userCompaniesRepository.fetchCompaniesAssociatedWithUser(user.uid);
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
      .watchCompaniesAssociatedWithUser(user.uid)
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
    user.uid,
    currentSelectedCompany.id,
  );
}
