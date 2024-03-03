import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_user_companies.dart';

import 'package:irrigazione_iot/src/features/user_companies/data/user_companies_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';

import 'package:irrigazione_iot/src/features/user_companies/domain/user_company.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeUserCompaniesRepository implements UserCompaniesRepository {
  FakeUserCompaniesRepository({this.addDelay = true});
  final bool addDelay;

  /// Preload userCompanies
  final _userCompanies =
      InMemoryStore<List<UserCompany>>(List.from(kFakeUserCompanies));

  // A stream to watch the list of userCompanies connected to a user
  @override
  Stream<List<UserCompany>> watchCompaniesAssociatedWithUser(String userId) {
    return _userCompanies.stream.map(
      (userCompanies) => _getUserCompanies(userCompanies, userId),
    );
  }

  @override
  Future<List<UserCompany>> fetchCompaniesAssociatedWithUser(
      String userId) async {
    await delay(addDelay);
    return Future.value(_getUserCompanies(_userCompanies.value, userId));
  }

  static List<UserCompany> _getUserCompanies(
      List<UserCompany> userCompanies, String userId) {
    return userCompanies.where((data) => data.appUser.uid == userId).toList();
  }

  @override
  Future<CompanyUserRoles?> fetchCompanyUserRole(
      String userId, CompanyID companyId) async {
    await delay(addDelay);
    final userCompanies = await fetchCompaniesAssociatedWithUser(userId);
    try {
      return userCompanies.firstWhere((val) => val.companyId == companyId).role;
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<CompanyUserRoles?> watchCompanyUserRole(
      String userId, CompanyID companyId) {
    return watchCompaniesAssociatedWithUser(userId).map((userCompanies) {
      try {
        return userCompanies
            .firstWhere((val) => val.companyId == companyId)
            .role;
      } catch (e) {
        return null;
      }
    });
  }

  void dispose() => _userCompanies.close();
}
