import 'package:irrigazione_iot/src/features/collectors/data/fake_collector_pressure_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_pressure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collector_pressure_repository.g.dart';

abstract class CollectorPressureRepository {
  /// returns the most recent [CollectorPressure] if any for the collector with collectorId
  Future<CollectorPressure?> getCollectorPressure(
      {required String collectorId});

  /// emits the most recent [CollectorPressure] if any for the collector with collectorId
  Stream<CollectorPressure?> watchCollectorPressure(
      {required String collectorId});
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
    {required String collectorId}) {
  final collectorPressureRepository =
      ref.read(collectorPressureRepositoryProvider);
  return collectorPressureRepository.watchCollectorPressure(collectorId: collectorId);
}


@riverpod
Future<CollectorPressure?> collectorPressureFuture(
    CollectorPressureFutureRef ref,
    {required String collectorId}) {
  final collectorPressureRepository =
      ref.read(collectorPressureRepositoryProvider);
  return collectorPressureRepository.getCollectorPressure(collectorId: collectorId);
}