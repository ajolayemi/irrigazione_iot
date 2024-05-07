import 'package:collection/collection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_database_keys.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_user.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_user_database_keys.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseCompanyUsersRepository implements CompanyUsersRepository {
  SupabaseCompanyUsersRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<CompanyUser?> addCompanyUser(
      {required CompanyUser companyUser}) async {
    // set created_at and updated_at fields
    final data = companyUser
        .copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now())
        .toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'insert-company-user',
      body: InsertBody(data: data).toJson(),
    );

    return res.toObject<CompanyUser>(CompanyUser.fromJson);
  }

  @override
  Future<bool> deleteCompanyUser({required String companyUserId}) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-company-user',
      body: DeleteBody(ids: [companyUserId]).toJson(),
    );

    return res.onDelete;
  }

  @override
  Future<CompanyUser?> updateCompanyUser(
      {required CompanyUser companyUser}) async {
    // add the updated_at field
    final data = companyUser.copyWith(updatedAt: DateTime.now()).toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'update-company-user',
      body: UpdateBody(id: companyUser.id, data: data).toJson(),
    );

    return res.toObject<CompanyUser>(CompanyUser.fromJson);
  }

  @override
  Stream<List<Company>> watchCompaniesAssociatedWithUser(
      {required String email}) {
    // The email parameter is not used in the query because the companies table
    // has a RLS policy that filters the rows based on the user's email already in the backend
    final stc =
        _supabaseClient.companies.stream(primaryKey: [CompanyDatabaseKeys.id]);
    return stc.map((companies) =>
        companies.map((company) => Company.fromJson(company)).toList());
  }

  @override
  Stream<CompanyUser?> watchCompanyUser({required String companyUserId}) {
    final stream = _supabaseClient.companyUsers
        .stream(primaryKey: [CompanyUserDatabaseKeys.id])
        .eq(CompanyUserDatabaseKeys.id, companyUserId)
        .limit(1);

    return stream.map(
      (companyUser) => companyUser.isNotEmpty
          ? CompanyUser.fromJson(companyUser.first)
          : null,
    );
  }

  @override
  Stream<CompanyUserRoles?> watchCompanyUserRole({
    required String email,
    required String companyId,
  }) {
    // Get the list of users associated with the company
    final usersAssociatedWithCompany = watchUsersAssociatedWithCompany(
      companyId: companyId,
    );

    return usersAssociatedWithCompany.map((companyUser) {
      final user = companyUser.firstWhereOrNull(
        (user) => user?.email == email,
      );
      return user?.role;
    });
  }

  @override
  Stream<List<String>> watchEmailsAssociatedWithCompany(
      {required String companyId}) {
    // Users associated with the company
    final usersAssociatedWithCompany = watchUsersAssociatedWithCompany(
      companyId: companyId,
    );

    return usersAssociatedWithCompany.map(
      (companyUsers) => companyUsers
          .map((companyUser) => companyUser?.email)
          .whereNotNull()
          .toList(),
    );
  }

  @override
  Stream<List<CompanyUser?>> watchUsersAssociatedWithCompany({
    required String companyId,
  }) {
    final stream = _supabaseClient.companyUsers
        .stream(primaryKey: [CompanyUserDatabaseKeys.id]).eq(
      CompanyUserDatabaseKeys.companyId,
      companyId,
    );

    return stream.map(
      (companyUsers) => companyUsers
          .map((companyUser) => CompanyUser.fromJson(companyUser))
          .toList(),
    );
  }
}
