import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';

class SupabaseCompanyUsersRepository implements CompanyUsersRepository {
  SupabaseCompanyUsersRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;


  @override
  Future<CompanyUser?> addCompanyUser({required CompanyUser companyUser}) {
    // TODO: implement addCompanyUser
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCompanyUser({required String companyUserId}) {
    // TODO: implement deleteCompanyUser
    throw UnimplementedError();
  }

  @override
  Future<List<CompanyUser>> fetchCompaniesAssociatedWithUser(
      {required String email}) {
    // TODO: implement fetchCompaniesAssociatedWithUser
    throw UnimplementedError();
  }

  @override
  Future<CompanyUser?> fetchCompanyUser({required String companyUserId}) {
    // TODO: implement fetchCompanyUser
    throw UnimplementedError();
  }

  @override
  Future<CompanyUserRoles?> fetchCompanyUserRole(
      {required String email, required String companyId}) {
    // TODO: implement fetchCompanyUserRole
    throw UnimplementedError();
  }

  @override
  Future<List<CompanyUser?>> fetchUsersAssociatedWithCompany(
      {required String companyId}) {
    // TODO: implement fetchUsersAssociatedWithCompany
    throw UnimplementedError();
  }

  @override
  Future<CompanyUser?> updateCompanyUser({required CompanyUser companyUser}) {
    // TODO: implement updateCompanyUser
    throw UnimplementedError();
  }

  @override
  Stream<List<Company>> watchCompaniesAssociatedWithUser(
      {required String email}) {
    // The email parameter is not used in the query because the companies table
    // has a RLS policy that filters the rows based on the user's email already in the backendZ
    final stc = _supabaseClient.from('companies').stream(primaryKey: ['id']);
    return stc.map((companies) =>
        companies.map((company) => Company.fromJson(company)).toList());
  }

  @override
  Stream<CompanyUser?> watchCompanyUser({required String companyUserId}) {
    // TODO: implement watchCompanyUser
    throw UnimplementedError();
  }

  @override
  Stream<CompanyUserRoles?> watchCompanyUserRole(
      {required String email, required String companyId}) {
    // TODO: implement watchCompanyUserRole
    throw UnimplementedError();
  }

  @override
  Stream<List<String>> watchEmailsAssociatedWithCompany(
      {required String companyId}) {
    // TODO: implement watchEmailsAssociatedWithCompany
    throw UnimplementedError();
  }

  @override
  Stream<List<CompanyUser?>> watchUsersAssociatedWithCompany(
      {required String companyId}) {
    // TODO: implement watchUsersAssociatedWithCompany
    throw UnimplementedError();
  }
}
