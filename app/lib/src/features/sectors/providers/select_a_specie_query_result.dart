import 'package:irrigazione_iot/src/features/specie/data/specie_repository.dart';
import 'package:irrigazione_iot/src/features/specie/models/specie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_a_specie_query_result.g.dart';

@riverpod
class SelectASpecieQueryResult extends _$SelectASpecieQueryResult {
  @override
  List<Specie> build() {
    return ref.watch(speciesStreamProvider).valueOrNull ?? [];
  }

  void search(String query) {
    reset();
    // If query is not empty, filter the list of species based on the query
    if (query.isNotEmpty) {
      final copiedState = List<Specie>.from(state);
      state = copiedState
          .where((specie) =>
              specie.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    // If query is empty, reset the list of species to the original list
    else {
      reset();
    }
  }

  void reset() {
    state = ref.read(speciesStreamProvider).valueOrNull ?? [];
  }
}
