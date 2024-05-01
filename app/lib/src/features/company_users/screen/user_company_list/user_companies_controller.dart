import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_companies_controller.g.dart';

@Riverpod(keepAlive: true)
class UserCompaniesController extends _$UserCompaniesController {
  @override
  FutureOr<void> build() {}

  Future<void> updateTappedCompanyId(String companyId) async {
    final repo = ref.read(selectedCompanyRepositoryProvider);
    final uid = ref.read(authRepositoryProvider).currentUser?.uid ?? '';
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repo.updateSelectedCompanyId(uid, companyId));
    ref.invalidate(currentTappedCompanyProvider);
  }
}
