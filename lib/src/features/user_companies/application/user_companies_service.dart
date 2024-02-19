import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';

part 'user_companies_service.g.dart';

// A service class to abstract the logic of fetching the companies associated with a user
class UserCompaniesService {
  UserCompaniesService(this.ref);
  final Ref ref;

  AuthRepository get authRepository => ref.read(authRepositoryProvider);
  CompanyRepository get companyRepository =>
      ref.read(companyRepositoryProvider);
  static const String tappedCompanyPreferenceSuffix = 'tappedCompanyId';

  String get tappedCompanyPreferenceKey =>
      '${authRepository.currentUser?.uid}-$tappedCompanyPreferenceSuffix';

  // Load initial tapped company from shared preferences
  Future<Company?> loadTappedCompany() async {
    final prefs = await SharedPreferences.getInstance();
    final companyId = prefs.getString(tappedCompanyPreferenceKey);

    if (companyId != null) {
      return await companyRepository.fetchCompany(companyId);
    }
    return null;
  }

  Future<void> updateTappedCompany(Company company) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      tappedCompanyPreferenceKey,
      company.id,
    );
    ref.invalidate(currentTappedCompanyProvider);
  }
}

@Riverpod(keepAlive: true)
UserCompaniesService userCompaniesService(UserCompaniesServiceRef ref) {
  return UserCompaniesService(ref);
}

@Riverpod(keepAlive: true)
Future<Company?> initialTappedCompany(InitialTappedCompanyRef ref) {
  return ref.read(userCompaniesServiceProvider).loadTappedCompany();
}

@Riverpod(keepAlive: true)
Future<Company?> currentTappedCompany(CurrentTappedCompanyRef ref) {
  return ref.read(userCompaniesServiceProvider).loadTappedCompany();
}
