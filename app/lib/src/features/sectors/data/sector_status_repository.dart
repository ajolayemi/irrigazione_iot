import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/data/supabase_sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/shared/models/item_status_request.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';
import 'package:irrigazione_iot/src/shared/services/mqtt_client_service.dart';

part 'sector_status_repository.g.dart';

abstract class SectorStatusRepository {
  /// Emits a stream of the most recent [SectorStatus] for the sector
  Stream<SectorStatus?> watchSectorStatus(String sectorId);

  /// Toggles the status of the sector
  Future<void> toggleSectorStatus({
    required ItemStatusRequest statusBody,
  });
}

@Riverpod(keepAlive: true)
SectorStatusRepository sectorStatusRepository(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  final mqttService = ref.watch(mqttClientServiceProvider);
  return SupabaseSectorStatusRepository(supabaseClient, mqttService);
}

@Riverpod(keepAlive: true)
Stream<SectorStatus?> sectorStatusStream(
  Ref ref,
  String sectorId,
) {
  final sectorStatusRepository = ref.watch(sectorStatusRepositoryProvider);
  return sectorStatusRepository.watchSectorStatus(sectorId);
}
