import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';

class SupabaseCompanyRepository implements CompanyRepository {
  const SupabaseCompanyRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<Company?> addCompany({required Company company}) {
    // TODO: implement addCompany
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCompany({required String companyId}) {
    // TODO: implement deleteCompany
    throw UnimplementedError();
  }

  @override
  Future<Company?> fetchCompany(String companyId) {
    // TODO: implement fetchCompany
    throw UnimplementedError();
  }

  @override
  Future<Company?> updateCompany({required Company company}) {
    // TODO: implement updateCompany
    throw UnimplementedError();
  }

  @override
  Stream<Company?> watchCompany(String companyId) {
    // TODO: implement watchCompany
    throw UnimplementedError();
  }
}
