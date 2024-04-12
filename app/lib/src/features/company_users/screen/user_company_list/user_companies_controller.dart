import '../../../authentication/data/auth_repository.dart';
import '../../data/selected_company_repository.dart';
import '../../model/company.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_companies_controller.g.dart';

@Riverpod(keepAlive: true)
class UserCompaniesController extends _$UserCompaniesController {
  @override
  FutureOr<void> build() {}

  Future<void> updateTappedCompanyId(CompanyID companyId) async {
    final repo = ref.read(selectedCompanyRepositoryProvider);
    final uid = ref.read(authRepositoryProvider).currentUser?.uid ?? '';
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repo.updateSelectedCompanyId(uid, companyId));
    ref.invalidate(currentTappedCompanyProvider);
  }
}
