// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_a_variety_query_result.g.dart';

@riverpod
class SelectAVarietyQueryResult extends _$SelectAVarietyQueryResult {
  @override
  FutureOr<List<Variety>?> build() =>
      ref.watch(varietiesFutureProvider).valueOrNull ?? [];

  void search(String query) {
    reset();

    if (query.isNotEmpty) {
      final currentState = [...state.valueOrNull ?? []];

      state = const AsyncLoading<List<Variety>?>();
      final filteredVarieties = currentState.where((variety) {
        final name = variety.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return name.contains(queryLower);
      }).toList();

      state = AsyncData<List<Variety>?>([...filteredVarieties]);
    } else {
      reset();
    }
  }

  void reset() {
    state = ref.read(varietiesFutureProvider);
  }
}
