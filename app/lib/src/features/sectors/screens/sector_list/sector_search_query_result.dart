import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sector_search_query_result.g.dart';

/// Responds to the search query on the sector list screen
@riverpod
class SectorSearchQueryResult extends _$SectorSearchQueryResult {
  @override
  List<Sector?> build() {
    return ref.watch(sectorListStreamProvider).valueOrNull ?? [];
  }

  void search(String query) {
    // first reset state
    resetState();

    // If query is not empty, filter the list of sectors based on the query
    if (query.isNotEmpty) {
      final copiedState = List<Sector?>.from(state);
      state = copiedState.where((sector) {
        return sector?.name.toLowerCase().contains(query.toLowerCase()) ??
            false;
      }).toList();
    }

    // If query is empty, reset the list of sectors to the original list
    else {
      resetState();
    }
  }

  void resetState() {
    state = ref.read(sectorListStreamProvider).valueOrNull ?? [];
  }
}
