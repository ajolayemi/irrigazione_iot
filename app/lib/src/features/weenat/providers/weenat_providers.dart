import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/shared/services/shared_preferences_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weenat_providers.g.dart';

/// Holds onto the current available weenat token retrieved from
///
/// shared preferences
@Riverpod(keepAlive: true)
FutureOr<String?> weenatToken(WeenatTokenRef ref) {
  final prefService = ref.watch(sharedPrefsServiceProvider);
  final uid = ref.watch(authRepositoryProvider).currentUser?.uid;
  return prefService.getUserWeenatToken(uid: uid);
}

@Riverpod(keepAlive: true)
bool hasWeenatToken(HasWeenatTokenRef ref) {
  final token = ref.watch(weenatTokenProvider).valueOrNull;
  return token != null && token.isNotEmpty;
}
