// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/models/specie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_a_specie_query_result.g.dart';

@riverpod
class SelectASpecieQueryResult extends _$SelectASpecieQueryResult {
  @override
  FutureOr<List<Specie>?> build() =>
      ref.watch(speciesFutureProvider).valueOrNull ?? [];

  void search(String query) {
    reset();
    // If query is not empty, filter the list of species based on the query
    if (query.isNotEmpty) {
      final currentState = [...state.valueOrNull ?? []];

      // set state to loading
      state = const AsyncLoading<List<Specie>?>();
      final filteredSpecies = currentState.where((specie) {
        final name = specie.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return name.contains(queryLower);
      }).toList();

      state = AsyncData<List<Specie>?>([...filteredSpecies]);
    }

    // If query is empty, reset the list of species to the original list
    else {
      reset();
    }
  }

  void reset() {
    state = ref.read(speciesFutureProvider);
  }
}
