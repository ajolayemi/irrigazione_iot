import '../../data/auth_repository.dart';
import '../../model/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
  FutureOr<void> build() {}

  Future<bool> signUpUser({
    required AppUser appUser,
    required String password,
  }) async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.signUp(appUser: appUser, password: password),
    );
    return !state.hasError;
  }
}
