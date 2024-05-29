import 'package:irrigazione_iot/src/features/variety/data/variety_repository.dart';
import 'package:irrigazione_iot/src/features/variety/models/variety.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_a_variety_query_result.g.dart';

@riverpod
class SelectAVarietyQueryResult extends _$SelectAVarietyQueryResult {
  @override
  List<Variety> build() => ref.watch(varietiesStreamProvider).valueOrNull ?? [];

  void search(String query) {
    reset();

    if (query.isNotEmpty) {
      final copiedState = List<Variety>.from(state);

      state = copiedState.where((variety) {
        final name = variety.name.toLowerCase();
        final search = query.toLowerCase();
        return name.contains(search);
      }).toList();
    } else {
      reset();
    }
  }

  void reset() {
    state = ref.read(varietiesStreamProvider).valueOrNull ?? [];
  }
}
