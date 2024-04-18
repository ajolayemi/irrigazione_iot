import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';

class SupabaseCompanyUsersRepository implements CompanyUsersRepository {
  SupabaseCompanyUsersRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  PostgrestFilterBuilder<List<Map<String, dynamic>>>
      _staticRelationSelectQuery() => _supabaseClient
          .from('company_users')
          .select(''' company: company_id(*) ''');

  List<Company> _convertCompanies(List<Map<String, dynamic>> data) {
    return data
        .map((e) => Company.fromJson(e['company'] as Map<String, dynamic>))
        .toList();
  }

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
    return _staticRelationSelectQuery()
        .eq('email', email)
        .withConverter((data) => _convertCompanies(data))
        .asStream();
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
