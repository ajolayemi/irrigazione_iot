import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/providers/shared_prefs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'selected_company_repository.g.dart';

class SelectedCompanyRepository {
  const SelectedCompanyRepository({
    required this.prefs,
  });

  final SharedPreferences prefs;

  static const String prefKey = 'tappedCompanyId';

  String? loadSelectedCompanyId(String uid) => prefs.getString('$uid-$prefKey');

  Future<void> updateSelectedCompanyId(String uid, String companyId) async {
    await prefs.setString('$uid-$prefKey', companyId);
  }
}

@Riverpod(keepAlive: true)
SelectedCompanyRepository selectedCompanyRepository(
    SelectedCompanyRepositoryRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider).requireValue;
  return SelectedCompanyRepository(prefs: prefs);
}

// The provider that tracks and fetches the current tapped company object
@Riverpod(keepAlive: true)
Future<Company?> currentTappedCompany(CurrentTappedCompanyRef ref) {
  final uid = ref.watch(authRepositoryProvider).currentUser?.uid;
  final companyId = ref
      .watch(selectedCompanyRepositoryProvider)
      .loadSelectedCompanyId(uid ?? '');
  if (companyId == null) return Future.value(null);
  final companyRepo = ref.watch(companyRepositoryProvider);
  return companyRepo.fetchCompany(companyId);
}
