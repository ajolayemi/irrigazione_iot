import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/data/supabase_sector_status_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sector_status_repository.g.dart';

abstract class SectorStatusRepository {
  /// Emits a stream of the most recent status for the sector
  Stream<bool?> watchSectorStatus(String sectorId);

  /// Toggles the status of the sector
  Future<void> toggleSectorStatus(
      {required String sectorId,
      required String statusString,
      required bool statusBoolean});
}

@Riverpod(keepAlive: true)
SectorStatusRepository sectorStatusRepository(SectorStatusRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSectorStatusRepository(supabaseClient);
}

@riverpod
Stream<bool?> sectorStatusStream(SectorStatusStreamRef ref, String sectorId) {
  final sectorStatusRepository = ref.watch(sectorStatusRepositoryProvider);
  return sectorStatusRepository.watchSectorStatus(sectorId);
}
