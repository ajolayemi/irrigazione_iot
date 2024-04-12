import '../../data/company_users_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_company_user_controller.g.dart';

@riverpod
class DismissCompanyUserController extends _$DismissCompanyUserController {
  @override
  FutureOr<void> build() {
    // no initialization to do
  }

  Future<bool> dismissCompanyUser(String companyUserId) async {
    final repo = ref.read(companyUsersRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repo.deleteCompanyUser(companyUserId: companyUserId));
    return !state.hasError;
  }
}