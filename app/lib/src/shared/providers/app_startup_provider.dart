import 'package:irrigazione_iot/src/application/di/service_locator.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
import 'package:irrigazione_iot/src/shared/providers/shared_prefs_provider.dart';
import 'package:irrigazione_iot/src/shared/services/local_data_sync_service.dart';
import 'package:irrigazione_iot/src/shared/services/mqtt_client_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPreferencesProvider);
    ref.invalidate(localSyncServiceProvider);
  });

  await ServiceLocator.init();
  await ref.read(sharedPreferencesProvider.future);
  await ref.read(weenatTokenProvider.future);
  await ref.read(mqttServerClientProvider.future);

  final localSyncService = await ref.read(localSyncServiceProvider.future);
  await localSyncService.syncServerDataToLocalStorage();
  return;
}
