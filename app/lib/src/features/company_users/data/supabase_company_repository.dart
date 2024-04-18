import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';

class SupabaseCompanyRepository implements CompanyRepository {
  const SupabaseCompanyRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  Company? _companyFromJson(Map<String, dynamic>? data) =>
      data == null ? null : Company.fromJson(data);

  Company? _companyFromJsonSingle(List<Map<String, dynamic>> data) =>
      data.isEmpty ? null : Company.fromJson(data.first);

  @override
  Future<Company?> addCompany({required Company company}) async {
    // set created_at and updated_at fields
    final data = company
        .copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
        .toJson();

    final res = await _supabaseClient.invokeFunction(
      functionName: 'insert-company',
      body: {'data': data},
    );

    return res.toObject<Company>(Company.fromJson);
  }

  @override
  Future<Company?> updateCompany({required Company company}) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'update-company',
      body: {
        'id': company.id,
        'data': company
            .copyWith(
              updatedAt: DateTime.now(),
            )
            .toJson(),
      },
    );

    return res.toObject<Company>(Company.fromJson);
  }

  @override
  Future<bool> deleteCompany({required String companyId}) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-company',
      body: {
        'ids': [
          companyId,
        ]
      },
    );

    return res.onDelete;
  }

  @override
  Future<Company?> fetchCompany(String companyId) =>
      _supabaseClient.selectedCompanies
          .eq(CompanyDatabaseKeys.id, companyId)
          .maybeSingle()
          .withConverter(_companyFromJson);

  @override
  Stream<Company?> watchCompany(String companyId) {
    final companyStream = _supabaseClient.companies
        .stream(primaryKey: [CompanyDatabaseKeys.id])
        .eq(CompanyDatabaseKeys.id, companyId)
        .limit(1);
    return companyStream.map(_companyFromJsonSingle);
  }
}
