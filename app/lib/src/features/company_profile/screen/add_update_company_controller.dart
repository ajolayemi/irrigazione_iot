import '../../company_users/data/company_repository.dart';
import '../../company_users/model/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_company_controller.g.dart';

@riverpod
class AddUpdateCompanyController extends _$AddUpdateCompanyController {
  @override
  FutureOr<void> build() {}

  Future<bool> addCompany(Company? company) async {
    final companyRepo = ref.read(companyRepositoryProvider);
    state = const AsyncLoading();
    if (company == null) {
      state = AsyncError(
        'no company object provided for creation',
        StackTrace.current,
      );
      return Future.value(false);
    }
    state = await AsyncValue.guard(
      () => companyRepo.addCompany(company: company),
    );
    return !state.hasError;
  }


  Future<bool> updateCompany(Company? company) async {
    final companyRepo = ref.read(companyRepositoryProvider);
    state = const AsyncLoading();
    if (company == null) {
      state = AsyncError(
        'no company object provided for update',
        StackTrace.current,
      );
      return false;
    }

    state = await AsyncValue.guard(
      () => companyRepo.updateCompany(company: company),
    );
    return !state.hasError;
  }
}
