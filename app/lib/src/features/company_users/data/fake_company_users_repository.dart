import 'dart:async';

import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/config/mock/fake_company_users.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeCompanyUsersRepository implements CompanyUsersRepository {
  FakeCompanyUsersRepository({this.addDelay = true});
  final bool addDelay;

  /// Preload userCompanies
  final _userCompanies =
      InMemoryStore<List<CompanyUser>>(List.from(kFakeCompanyUsers));

  final _companies = InMemoryStore<List<Company>>(List.from(kFakeCompanies));

  List<CompanyUser> get _companyUsersValue => _userCompanies.value;

  Stream<List<CompanyUser>> get _companyUsersStream => _userCompanies.stream;

  static List<CompanyUser> _getUserCompanies(
      List<CompanyUser> userCompanies, String email) {
    return userCompanies.where((data) => data.email == email).toList();
  }

  static Company _getCompany(List<Company> companies, String companyId) {
    return companies.firstWhere((data) => data.id == companyId);
  }

  static List<CompanyUser?> _getUsersMailAssociatedWithCompany(
      List<CompanyUser> userCompanies, String companyId) {
    return userCompanies.where((data) => data.companyId == companyId).toList();
  }

  CompanyUser? _getCompanyUser({required String companyUserId}) {
    return _companyUsersValue.firstWhereOrNull(
      (user) => user.id.toString() == companyUserId,
    );
  }

  // A stream to watch the list of userCompanies connected to a user
  @override
  Stream<List<Company>> watchCompaniesAssociatedWithUser(
      {required String email}) {
    final userCompanies = _userCompanies.stream.map(
      (userCompanies) => _getUserCompanies(userCompanies, email),
    );
    return userCompanies.map((userCs) => userCs
        .map((userCompany) =>
            _getCompany(_companies.value, userCompany.companyId))
        .toList());
  }

  @override
  Stream<CompanyUserRoles?> watchCompanyUserRole(
      {required String email, required String companyId}) {
    final userCompaniesStream = _userCompanies.stream.map(
      (userCompanies) => _getUserCompanies(userCompanies, email),
    );
    return userCompaniesStream.map((userCompanies) {
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
        .map((e) => int.tryParse(e.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);

    // just the id is set here, all other values are provided or added from form
    final newCompanyUser = companyUser.copyWith(id: '${lastId + 1}');
    currentUsers.add(newCompanyUser);
    _userCompanies.value = currentUsers;
    return _getCompanyUser(companyUserId: newCompanyUser.id.toString());
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
    return _getCompanyUser(companyUserId: companyUserId) == null;
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
    return _getCompanyUser(companyUserId: companyUser.id.toString());
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
  Stream<List<String>> watchEmailsAssociatedWithCompany(
      {required String companyId}) {
    return _companyUsersStream.map(
      (userCompanies) => userCompanies
          .where((user) => user.companyId == companyId)
          .map((user) => user.email)
          .toList(),
    );
  }
}
