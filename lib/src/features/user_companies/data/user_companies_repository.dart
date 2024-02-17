import 'package:irrigazione_iot/src/features/user_companies/application/user_companies_service.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/user_companies/data/fake_user_companies_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/user_company.dart';

part 'user_companies_repository.g.dart';

// A repository to manage the companies connected to a user
// When either Supabase or Firebase is implemented, the repository that will be connected
// to this class will access the table where the users associated with the companies are stored
abstract class UserCompaniesRepository {
  Stream<List<UserCompany>> watchCompaniesAssociatedWithUser(String userId);
  Future<List<UserCompany>> fetchCompaniesAssociatedWithUser(String userId);
}

// TODO replace this with a real implementation of either Firebase or Supabase
@Riverpod(keepAlive: true)
UserCompaniesRepository userCompaniesRepository(
    UserCompaniesRepositoryRef ref) {
  return FakeUserCompaniesRepository();
}

@riverpod
Future<List<Company>> userCompaniesFuture(
    UserCompaniesFutureRef ref, String userId) {
  final repository = ref.watch(userCompaniesServiceProvider);
  return repository.fetchUserCompanies();
}

@riverpod
Stream<List<Company>> userCompaniesStream(UserCompaniesStreamRef ref) {
  final userCompaniesService = ref.read(userCompaniesServiceProvider);
  return userCompaniesService.watchUserCompanies();
}
