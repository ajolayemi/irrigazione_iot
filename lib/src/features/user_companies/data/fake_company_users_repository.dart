import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_company_users.dart';

import 'package:irrigazione_iot/src/features/user_companies/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company_user.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeUserCompaniesRepository implements CompanyUsersRepository {
  FakeUserCompaniesRepository({this.addDelay = true});
  final bool addDelay;

  /// Preload userCompanies
  final _userCompanies =
      InMemoryStore<List<CompanyUser>>(List.from(kFakeCompanyUsers));

  // A stream to watch the list of userCompanies connected to a user
  @override
  Stream<List<CompanyUser>> watchCompaniesAssociatedWithUser({required String email}) {
    return _userCompanies.stream.map(
      (userCompanies) => _getUserCompanies(userCompanies, email),
    );
  }

  @override
  Future<List<CompanyUser>> fetchCompaniesAssociatedWithUser(
      {required String email}) async {
    await delay(addDelay);
    return Future.value(_getUserCompanies(_userCompanies.value, email));
  }

  static List<CompanyUser> _getUserCompanies(
      List<CompanyUser> userCompanies, String email) {
    return userCompanies.where((data) => data.email == email).toList();
  }

  @override
  Future<CompanyUserRoles?> fetchCompanyUserRole(
      {required String email, required String companyId}) async {
    await delay(addDelay);
    final userCompanies = await fetchCompaniesAssociatedWithUser(email: email);
    try {
      return userCompanies.firstWhere((val) => val.companyId == companyId).role;
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<CompanyUserRoles?> watchCompanyUserRole(
      {required String email, required String companyId}) {
    return watchCompaniesAssociatedWithUser(email: email).map((userCompanies) {
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
