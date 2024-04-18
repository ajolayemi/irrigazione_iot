import 'package:collection/collection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_database_keys.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_client_extension.dart';

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
      body: {'data': data},
    );

    final returnedData = res.data;

    if (returnedData == null) {
      return null;
    }

    return CompanyUser.fromJson(returnedData[0]);
  }

  @override
  Future<bool> deleteCompanyUser({required String companyUserId}) async {
    final res = await _supabaseClient
        .invokeFunction(functionName: 'delete-company-user', body: {
      'ids': [
        companyUserId,
      ]
    });

    final status = res.status;
    return status == 200 || status == 204;
  }

  @override
  Future<CompanyUser?> updateCompanyUser(
      {required CompanyUser companyUser}) async {
    final res = await _supabaseClient
        .invokeFunction(functionName: 'update-company-user', body: {
      'id': companyUser.id,
      'data': companyUser.copyWith(updatedAt: DateTime.now()).toJson(),
    });

    final returnedData = res.data;

    if (returnedData == null) {
      return null;
    }

    return CompanyUser.fromJson(returnedData[0]);
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
