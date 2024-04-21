import '../../../../utils/custom_controller_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/auth_repository.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  static const String signInStateKey = 'sign-in';
  static const String googleSignInStateKey = 'google-sign-in';
  final _initState = const CustomControllerState(loadingStates: {});
  @override
  FutureOr<CustomControllerState> build() {
    state = AsyncData<CustomControllerState>(_initState);
    return _initState;
  }

  void _setLoading(String buttonKey, bool isLoading) {
    state = AsyncData(state.value!.setLoading(buttonKey, isLoading));
  }

  Future<bool> authenticateWithEmailAndPassword(
    String email,
    String password,
  ) async {
    // The controller build method is called when the controller is initialized
    // and so, to prevent having a previous state, we set the state to the initial state
    // when this method is called
    state = AsyncData<CustomControllerState>(_initState);
    _setLoading(signInStateKey, true);
    // set state to loading
    state = const AsyncLoading<CustomControllerState>().copyWithPrevious(state);
    // call on the repository function to handle user sign in with email and password
    final authRepo = ref.read(authRepositoryProvider);
    final value = await AsyncValue.guard(
      () => authRepo.signInWithEmailAndPassword(
        email,
        password,
      ),
    );
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData<CustomControllerState>(_initState);
    }
    return !state.hasError;
  }

  Future<bool> authenticateWithGoogle() async {
    // The controller build method is called when the controller is initialized
    // and so, to prevent having a previous state, we set the state to the initial state
    // when this method is called
    state = AsyncData<CustomControllerState>(_initState);
    _setLoading(googleSignInStateKey, true);
    // set state to loading
    state = const AsyncLoading<CustomControllerState>().copyWithPrevious(state);
    // call on the repository function to handle user sign in with google
    final authRepo = ref.read(authRepositoryProvider);
    final value = await AsyncValue.guard(
      () => authRepo.signInWithGoogle(),
    );
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData<CustomControllerState>(_initState);
    }
    return !state.hasError;
  }
}
