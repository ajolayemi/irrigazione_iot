import 'dart:async';

import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_company_users.dart';

import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeUserCompaniesRepository implements CompanyUsersRepository {
  FakeUserCompaniesRepository({this.addDelay = true});
  final bool addDelay;

  /// Preload userCompanies
  final _userCompanies =
      InMemoryStore<List<CompanyUser>>(List.from(kFakeCompanyUsers));

  List<CompanyUser> get _companyUsersValue => _userCompanies.value;

  Stream<List<CompanyUser>> get _companyUsersStream => _userCompanies.stream;

  static List<CompanyUser> _getUserCompanies(
      List<CompanyUser> userCompanies, String email) {
    return userCompanies.where((data) => data.email == email).toList();
  }

  static List<CompanyUser?> _getUsersMailAssociatedWithCompany(
      List<CompanyUser> userCompanies, String companyId) {
    return userCompanies.where((data) => data.companyId == companyId).toList();
  }

  // A stream to watch the list of userCompanies connected to a user
  @override
  Stream<List<CompanyUser>> watchCompaniesAssociatedWithUser(
      {required String email}) {
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

  @override
  Future<CompanyUser?> addCompanyUser(
      {required CompanyUser companyUser}) async {
    await delay(addDelay);
    final currentUsers = [..._companyUsersValue];
    final lastId = currentUsers
        .map((e) => e.id)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);

    // just the id is set here, all other values are provided or added from form
    final newCompanyUser = companyUser.copyWith(id: lastId + 1);
    currentUsers.add(newCompanyUser);
    _userCompanies.value = currentUsers;
    return fetchCompanyUser(companyUserId: newCompanyUser.id.toString());
  }

  @override
  Future<bool> deleteCompanyUser({required String companyUserId}) async {
    await delay(addDelay);
    final currentUsers = [..._companyUsersValue];
    final index = currentUsers.indexWhere(
      (user) => user.id.toString() == companyUserId,
    );
    if (index == -1) return false;
    currentUsers.removeAt(index);
    _userCompanies.value = currentUsers;
    return await fetchCompanyUser(companyUserId: companyUserId) == null;
  }

  @override
  Future<CompanyUser?> updateCompanyUser(
      {required CompanyUser companyUser}) async {
    await delay(addDelay);
    final currentUsers = [..._companyUsersValue];
    final index = currentUsers.indexWhere(
      (user) => user.id == companyUser.id,
    );
    if (index == -1) return null;
    currentUsers[index] = companyUser;
    _userCompanies.value = currentUsers;
    return fetchCompanyUser(companyUserId: companyUser.id.toString());    
 }

  @override
  Future<List<CompanyUser?>> fetchUsersAssociatedWithCompany(
      {required String companyId}) async {
    await delay(addDelay);
    return Future.value(
        _getUsersMailAssociatedWithCompany(_companyUsersValue, companyId));
  }

  @override
  Stream<List<CompanyUser?>> watchUsersAssociatedWithCompany(
      {required String companyId}) {
    return _companyUsersStream.map(
      (userCompanies) =>
          _getUsersMailAssociatedWithCompany(userCompanies, companyId),
    );
  }

  void dispose() => _userCompanies.close();

  @override
  Stream<CompanyUser?> watchCompanyUser({required String companyUserId}) {
    return _companyUsersStream.map(
      (userCompanies) => userCompanies.firstWhereOrNull(
        (user) => user.id.toString() == companyUserId,
      ),
    );
  }

  @override
  Future<CompanyUser?> fetchCompanyUser({required String companyUserId}) async {
    await delay(addDelay);
    return Future.value(
      _companyUsersValue.firstWhereOrNull(
        (user) => user.id.toString() == companyUserId,
      ),
    );
  }
}
