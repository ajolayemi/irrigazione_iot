// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_search_query_result.g.dart';

/// Responsible for filtering the list of pumps based on the search query.
@riverpod
class PumpSearchQueryResult extends _$PumpSearchQueryResult {
  @override
  FutureOr<List<Pump>?> build() {
    final data = ref.watch(companyPumpsFutureProvider).valueOrNull ?? [];
    return data;
  }

  void search(String query) {
    reset();
    // If query is not empty, filter the list of pumps based on the query
    if (query.isNotEmpty) {
      final currentState = [...state.valueOrNull ?? []];

      // set state to loading
      state = const AsyncLoading<List<Pump>?>();
      final filteredPumps = currentState.where((pump) {
        final name = pump.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return name.contains(queryLower);
      }).toList();

      state = AsyncData<List<Pump>>([...filteredPumps]);
    }

    // If query is empty, reset the list of pumps to the original list
    else {
      reset();
    }
  }

  void reset() {
    state = ref.read(companyPumpsFutureProvider);
  }
}
