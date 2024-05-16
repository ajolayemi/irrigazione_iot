import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/data/supabase_available_sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/available_sector.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'available_sector_repository.g.dart';

abstract class AvailableSectorRepository {
  Stream<List<AvailableSector>?> watchAvailableSectors(
    String companyId, {
    List<AvailableSector>? sectorsAlreadyConnectedToCollector,
  });
}

@Riverpod(keepAlive: true)
AvailableSectorRepository availableSectorRepository(
    AvailableSectorRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseAvailableSectorRepository(supabaseClient);
}

/// Emits the list of sectors for the current company that aren't yet connected
/// to a collector. If a collectorId is provided, the emitted list will include
/// the sectors already connected to the collector.
@riverpod
Stream<List<AvailableSector>?> availableSectorsStream(
    AvailableSectorsStreamRef ref,
    {String? collectorId}) {
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Stream.value([]);

  if (collectorId == null || collectorId.isEmpty) {
    return ref
        .read(availableSectorRepositoryProvider)
        .watchAvailableSectors(companyId);
  }
  final sectorsAlreadyConnectedToCollector = ref
      .watch(
        collectorSectorsStreamProvider(collectorId),
      )
      .valueOrNull;
  List<AvailableSector>? toAvailableSectors = sectorsAlreadyConnectedToCollector
      ?.map((e) => AvailableSector(
            sectorId: e!.sectorId,
            companyId: companyId,
          ))
      .toList();

  return ref.read(availableSectorRepositoryProvider).watchAvailableSectors(
        companyId,
        sectorsAlreadyConnectedToCollector: toAvailableSectors,
      );
}
