import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/user_companies_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_companies_service.g.dart';


// A service class to abstract the logic of fetching the companies associated with a user
class UserCompaniesService {
  UserCompaniesService(this.ref);
  final Ref ref;

  CompanyRepository get companyRepository =>
      ref.read(companyRepositoryProvider);
  UserCompaniesRepository get userCompaniesRepository =>
      ref.read(userCompaniesRepositoryProvider);
  AuthRepository get authRepository => ref.read(authRepositoryProvider);
  Future<List<Company>> fetchUserCompanies() async {
    final user = authRepository.currentUser;

    if (user == null) {
      return [];
    }
    final userCompanies = await userCompaniesRepository
        .fetchCompaniesAssociatedWithUser(user.uid);
    final companies = <Company>[];
    for (final userCompany in userCompanies) {
      final company =
          await companyRepository.fetchCompany(userCompany.companyId);
      if (company != null) {
        companies.add(company);
      }
    }
    return companies;
  }

  Stream<List<Company>> watchUserCompanies() {
    final user = authRepository.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
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
}

@riverpod
UserCompaniesService userCompaniesService(UserCompaniesServiceRef ref) {
  return UserCompaniesService(ref);
}
