import 'fake_collector_pressure_repository.dart';
import '../model/collector.dart';
import '../model/collector_pressure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collector_pressure_repository.g.dart';

abstract class CollectorPressureRepository {
  /// returns the most recent [CollectorPressure] if any for the collector with [CollectorID]
  Future<CollectorPressure?> getCollectorPressure(
      {required CollectorID collectorId});

  /// emits the most recent [CollectorPressure] if any for the collector with [CollectorID]
  Stream<CollectorPressure?> watchCollectorPressure(
      {required CollectorID collectorId});
}

@Riverpod(keepAlive: true)
CollectorPressureRepository collectorPressureRepository(
    CollectorPressureRepositoryRef ref) {
  // todo return remote repository as default
  return FakeCollectorPressureRepository();
}

@riverpod
Stream<CollectorPressure?> collectorPressureStream(
    CollectorPressureStreamRef ref,
    {required CollectorID collectorId}) {
  final collectorPressureRepository =
      ref.read(collectorPressureRepositoryProvider);
  return collectorPressureRepository.watchCollectorPressure(collectorId: collectorId);
}


@riverpod
Future<CollectorPressure?> collectorPressureFuture(
    CollectorPressureFutureRef ref,
    {required CollectorID collectorId}) {
  final collectorPressureRepository =
      ref.read(collectorPressureRepositoryProvider);
  return collectorPressureRepository.getCollectorPressure(collectorId: collectorId);
}