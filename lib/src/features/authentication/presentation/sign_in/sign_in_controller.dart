import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  @override
  FutureOr<void> build() {
    // No implementation
  }

  Future<bool> authenticateWithEmailAndPassword(
      String email, String password) async {
    // set state to loading
    state = const AsyncValue.loading();
    // call on the repository function to handle user sign in with email and password
    final authRepo = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(
      () => authRepo.signInWithEmailAndPassword(
        email,
        password,
      ),
    );
    return state.hasError == false;
  }

  Future<bool> authenticateWithGoogle() async {
    // set state to loading
    state = const AsyncValue.loading();
    // call on the repository function to handle user sign in with google
    final authRepo = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(
      () => authRepo.signInWithGoogle(),
    );
    return state.hasError == false;
  }
}
