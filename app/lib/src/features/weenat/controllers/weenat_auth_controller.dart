import 'package:irrigazione_iot/src/features/weenat/models/weenat_auth_payload.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/weenat/services/weenat_service.dart';

part 'weenat_auth_controller.g.dart';

@riverpod
class WeenatAuthController extends _$WeenatAuthController {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<bool> authWeenat({
    required WeenatAuthPayload payload,
  }) async {
    state = const AsyncLoading<void>();

    final service = ref.read(weenatServiceProvider);
    final value = await AsyncValue.guard(
      () => service.authWeenatService(payload: payload),
    );

    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData<void>(null);
    }

    return !state.hasError;
  }
}
