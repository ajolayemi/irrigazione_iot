import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/data/supabase_sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/shared/models/firebase_callable_function_body.dart';
import 'package:irrigazione_iot/src/shared/providers/firebase_providers.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'sector_status_repository.g.dart';

abstract class SectorStatusRepository {
  /// Emits a stream of the most recent [SectorStatus] for the sector
  Stream<SectorStatus?> watchSectorStatus(String sectorId);

  /// Toggles the status of the sector
  Future<void> toggleSectorStatus({
    required FirebaseCallableFunctionBody statusBody,
  });
}

@Riverpod(keepAlive: true)
SectorStatusRepository sectorStatusRepository(SectorStatusRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  final firebaseFunc = ref.read(firebaseFunctionsProvider);
  return SupabaseSectorStatusRepository(supabaseClient, firebaseFunc);
}

@riverpod
Stream<SectorStatus?> sectorStatusStream(SectorStatusStreamRef ref, String sectorId) {
  final sectorStatusRepository = ref.watch(sectorStatusRepositoryProvider);
  return sectorStatusRepository.watchSectorStatus(sectorId);
}
