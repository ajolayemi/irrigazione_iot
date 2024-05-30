// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sector_search_query_result.g.dart';

/// Responds to the search query on the sector list screen
@riverpod
class SectorSearchQueryResult extends _$SectorSearchQueryResult {
  @override
  FutureOr<List<Sector>?> build() {
    return ref.watch(companySectorsFutureProvider).valueOrNull ?? [];
  }

  void search(String query) {
    // first reset state
    reset();

    // If query is not empty, filter the list of sectors based on the query
    if (query.isNotEmpty) {
      final currentState = [...state.valueOrNull ?? []];

      state = const AsyncLoading<List<Sector>?>();
      final filteredSectors = currentState.where((sector) {
        final name = sector.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return name.contains(queryLower);
      }).toList();

      state = AsyncData<List<Sector>>([...filteredSectors]);
    }

    // If query is empty, reset the list of sectors to the original list
    else {
      reset();
    }
  }

  void reset() {
    state = ref.read(companySectorsFutureProvider);
  }
}
