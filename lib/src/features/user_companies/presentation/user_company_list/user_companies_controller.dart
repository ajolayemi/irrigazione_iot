import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_companies_controller.g.dart';

@Riverpod(keepAlive: true)
class UserCompaniesController extends _$UserCompaniesController {
  @override
  FutureOr<void> build() {}

  Future<void> updateTappedCompany(CompanyID companyId) async {
    final repo = ref.read(selectedCompanyRepositoryProvider);
    final uid = ref.read(authRepositoryProvider).currentUser?.uid ?? '';
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repo.updateSelectedCompany(uid, companyId));
    ref.invalidate(currentTappedCompanyProvider);
  }
}
