import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_search_query_result.g.dart';

/// Notifier class that keeps track of the search query for the pump list.
/// This is used to filter the list of pumps based on the search query.
@riverpod
class PumpSearchQueryResult extends _$PumpSearchQueryResult {
  @override
  List<Pump?> build() {
    return ref.watch(companyPumpsStreamProvider).valueOrNull ?? [];
  }

  void setSearchQuery(String query) {
    resetSearchQuery();
    // If query is not empty, filter the list of pumps based on the query
    if (query.isNotEmpty) {
      final copiedState = List<Pump?>.from(state);
      state = copiedState.where((pump) {
        return pump?.name.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList();
    }

    // If query is empty, reset the list of pumps to the original list
    else {
      resetSearchQuery();
    }
  }

  void resetSearchQuery() {
    state = ref.read(companyPumpsStreamProvider).valueOrNull ?? [];
  }
}
