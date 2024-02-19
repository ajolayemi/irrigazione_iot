import 'package:irrigazione_iot/src/features/user_companies/data/fake_company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_repository.g.dart';

// When either Supabase or Firebase is implemented, the repository that will be connected
// to this class will access the table where the general data of all companies are stored
abstract class CompanyRepository {
  Future<Company?> fetchCompany(CompanyID companyId);
  Stream<Company?> watchCompany(CompanyID companyId);
}

@Riverpod(keepAlive: true)
CompanyRepository companyRepository(CompanyRepositoryRef ref) {
  return FakeCompanyRepository();
}

@riverpod
Future<Company?> companyFuture(CompanyFutureRef ref, CompanyID companyId) {
  final repository = ref.watch(companyRepositoryProvider);
  return repository.fetchCompany(companyId);
}

@riverpod
Stream<Company?> companyStream(CompanyStreamRef ref, CompanyID companyId) {
  final repository = ref.watch(companyRepositoryProvider);
  return repository.watchCompany(companyId);
}

