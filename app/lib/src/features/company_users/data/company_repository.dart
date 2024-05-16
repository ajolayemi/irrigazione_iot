import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/company_users/data/supabase_company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'company_repository.g.dart';

// When either Supabase or Firebase is implemented, the repository that will be connected
// to this class will access the table where the general data of all companies are stored
abstract class CompanyRepository {
  /// returns the [Company] with the given companyId if it exists
  Future<Company?> fetchCompany(String companyId);

  /// emits the [Company] with the given companyId
  Stream<Company?> watchCompany(String companyId);

  /// updates an existing [Company] in the database and returns the updated [Company] if successful
  Future<Company?> updateCompany({required Company company});

  /// adds a new [Company] to the database and returns the newly added [Company] if successful
  Future<Company?> addCompany({required Company company});

  /// deletes a [Company] from the database and returns true if successful
  Future<bool> deleteCompany({required String companyId});
}

@Riverpod(keepAlive: true)
CompanyRepository companyRepository(CompanyRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseCompanyRepository(supabaseClient);
}

@riverpod
Future<Company?> companyFuture(CompanyFutureRef ref, String companyId) {
  final repository = ref.watch(companyRepositoryProvider);
  return repository.fetchCompany(companyId);
}

@riverpod
Stream<Company?> companyStream(CompanyStreamRef ref, String companyId) {
  final repository = ref.watch(companyRepositoryProvider);
  return repository.watchCompany(companyId);
}
