import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_collector_service.g.dart';

class DismissCollectorService {
  const DismissCollectorService(
    this._ref,
  );
  final Ref _ref;

  /// Handles the deletion of all data related to a collector
  /// i.e the standard collector data and its connected sectors
  Future<void> dismissCollector(CollectorID collectorId) async {
    await delay(true, 9000);
    print('coming soonnnn');
  }
}

@riverpod
DismissCollectorService dismissCollectorService(Ref ref) {
  return DismissCollectorService(ref);
}
