import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_company_user_controller.g.dart';

@riverpod
class AddUpdateCompanyUserController extends _$AddUpdateCompanyUserController {
  @override
  FutureOr<void> build() {
    // no initialization needed
  }

  Future<bool> addUserToCompany(CompanyUser? companyUser) async {
    final companyUserRepo = ref.read(companyUsersRepositoryProvider);
    state = const AsyncLoading();
    if (companyUser == null) {
      state = AsyncError(
          'no companyUser object provided during creation', StackTrace.current);
      return Future.value(false);
    }
    final toAdd = companyUser.copyWith(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    state = await AsyncValue.guard(
        () => companyUserRepo.addCompanyUser(companyUser: toAdd));
    return !state.hasError;
  }
}
