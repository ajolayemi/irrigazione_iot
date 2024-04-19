import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/data/supabase_sector_pressure_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sector_pressure_repository.g.dart';

abstract class SectorPressureRepository {
  /// Emits the last time the sector with the provided [sectorId] had a pressure reading
  /// Which is also the last time the sector was irrigated
  Stream<DateTime?> watchLastPressureReading(String sectorId);
}

@Riverpod(keepAlive: true)
SectorPressureRepository sectorPressureRepository(
    SectorPressureRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseSectorPressureRepository(supabaseClient);
}

@riverpod
Stream<DateTime?> sectorLastPressureStream(
    SectorLastPressureStreamRef ref, String sectorId) {
  final sectorPressureRepository = ref.watch(sectorPressureRepositoryProvider);
  return sectorPressureRepository.watchLastPressureReading(sectorId);
}
