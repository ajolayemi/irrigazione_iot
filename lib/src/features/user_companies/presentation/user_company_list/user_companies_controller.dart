import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/domain/app_user.dart';
import 'package:irrigazione_iot/src/features/user_companies/application/user_companies_service.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_companies_controller.g.dart';

@Riverpod(keepAlive: true)
class UserCompaniesController extends _$UserCompaniesController {
  @override
  FutureOr<void> build() async {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) async {
      if (previous != next) {
        ref.invalidate(initialTappedCompanyProvider);
      }
    });
    return;
  }

  Future<void> updateTappedCompany(Company company) async {
    state = const AsyncLoading();
    final controllerService = ref.read(userCompaniesServiceProvider);
    state = await AsyncValue.guard(
        () => controllerService.updateTappedCompany(company));
  }
}
