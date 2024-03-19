import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_collector_service.g.dart';

class AddUpdateCollectorService {
  const AddUpdateCollectorService(
    this._ref,
  );
  final Ref _ref;

  Future<void> createCollector(Collector collector) async {
    print(
      'Creating collector coming soon...',
    ); // todo implement createCollector
  }

  Future<void> updateCollector(Collector collector) async {
    print('Update collector coming soon...');
    // todo implement updateCollector
  }
}

@riverpod
AddUpdateCollectorService addUpdateCollectorService(
    AddUpdateCollectorServiceRef ref) {
  return AddUpdateCollectorService(ref);
}
