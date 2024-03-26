import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/features/company_users/service/add_update_company_user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_company_user_controller.g.dart';

@riverpod
class AddUpdateCompanyUserController extends _$AddUpdateCompanyUserController {
  @override
  FutureOr<void> build() {
    // no initialization needed
  }

  Future<bool> addUserToCompany(CompanyUser? companyUser) async {
    final service = ref.read(addUpdateCompanyUserServiceProvider);
    state = const AsyncLoading();
    if (companyUser == null) {
      state = AsyncError(
          'no companyUser object provided during creation', StackTrace.current);
      return Future.value(false);
    }

    state = await AsyncValue.guard(() => service.addCompanyUser(companyUser));
    return !state.hasError;
  }

  Future<bool> updateUserInCompany(CompanyUser? companyUser) async {
    final service = ref.read(addUpdateCompanyUserServiceProvider);
    state = const AsyncLoading();
    if (companyUser == null) {
      state = AsyncError(
          'no companyUser object provided during update', StackTrace.current);
      return Future.value(false);
    }
    state =
        await AsyncValue.guard(() => service.updateCompanyUser(companyUser));
    return !state.hasError;
  }
}
