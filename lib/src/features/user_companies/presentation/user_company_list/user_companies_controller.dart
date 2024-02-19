import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/domain/app_user.dart';
import 'package:irrigazione_iot/src/features/user_companies/application/user_companies_service.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_companies_controller.g.dart';

@Riverpod(keepAlive: true)
class UserCompaniesController extends _$UserCompaniesController {
  Company? get tappedCompany => state.value;
  @override
  FutureOr<Company?> build() async {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) async {
      if (previous != next) {
        final controllerService = ref.read(userCompaniesServiceProvider);
        state =
            await AsyncValue.guard(() => controllerService.loadTappedCompany());
      }
    });
    return state.value;
  }

  Future<void> updateTappedCompany(Company company) async {
    state = const AsyncLoading();
    final controllerService = ref.read(userCompaniesServiceProvider);
    await controllerService.updateTappedCompany(company);
    state = await AsyncValue.guard(() => controllerService.loadTappedCompany());
  }
}
