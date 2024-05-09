import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/models/superuser_database_keys.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_user_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/models/superuser.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_user.dart';

class SupabaseRoleManagementRepository implements RoleManagementRepository {
  const SupabaseRoleManagementRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  String get _companyUsersTablePk => CompanyUserDatabaseKeys.id;
  String get _companyUsersCompanyId => CompanyUserDatabaseKeys.companyId;
  String get _superusersTablePk => SuperuserDatabaseKeys.id;
  String get _superuserEmail => SuperuserDatabaseKeys.email;
  String get _superuserTable => SuperuserDatabaseKeys.table;

  @override
  Stream<CompanyUserRole?> watchUserCompanyRole(
      String email, String companyId) {
    final usersPertainingToCompany = _supabaseClient.companyUsers.stream(
      primaryKey: [_companyUsersTablePk],
    ).eq(
      _companyUsersCompanyId,
      companyId,
    );

    final thisUser = usersPertainingToCompany.where(
      (data) => data.map((companyUser) => companyUser['email']).contains(email),
    );

    return thisUser.map(
      (data) => data.isEmpty ? null : CompanyUser.fromJson(data.first).role,
    );
  }

  @override
  Stream<SuperUser?> watchSuperuser(String email) {
    final superUserStream = _supabaseClient
        .from(_superuserTable)
        .stream(
          primaryKey: [_superusersTablePk],
        )
        .eq(
          _superuserEmail,
          email,
        )
        .limit(1);

    return superUserStream.map(
      (data) => data.isEmpty
          ? null
          : SuperUser.fromJson(
              data.first,
            ),
    );
  }

  @override
  Stream<bool> isBasicUser(String email, String companyId) =>
      watchUserCompanyRole(email, companyId).map(
        (role) => role?.isUser ?? false,
      );

  @override
  Stream<bool> isUserAdmin(String email, String companyId) =>
      watchUserCompanyRole(email, companyId).map(
        (role) => role?.isAdmin ?? false,
      );

  @override
  Stream<bool> isUserOwner(String email, String companyId) =>
      watchUserCompanyRole(email, companyId).map(
        (role) => role?.isOwner ?? false,
      );

  @override
  Stream<bool> isUserSuperuser(String email) => watchSuperuser(email).map(
        (superuser) => superuser != null,
      );
}
