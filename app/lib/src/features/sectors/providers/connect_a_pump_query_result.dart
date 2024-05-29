import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';

part 'connect_a_pump_query_result.g.dart';

@riverpod
class ConnectAPumpQueryResult extends _$ConnectAPumpQueryResult {
  @override
  List<Pump?> build() =>
      ref.watch(companyPumpsStreamProvider).valueOrNull ?? [];

  void search(String query) {
    reset();

    if (query.isNotEmpty) {
      final copiedState = [...state];
      state = copiedState.where((pump) {
        final name = pump?.name.toLowerCase();
        final search = query.toLowerCase();
        return name?.contains(search) ?? false;
      }).toList();
    } else {
      reset();
    }
  } 

  void reset() {
    state = ref.read(companyPumpsStreamProvider).valueOrNull ?? [];
  }
}
