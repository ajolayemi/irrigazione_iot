import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_status_repository.g.dart';

abstract class PumpStatusRepository {
  Stream<PumpStatus> watchPumpStatus(String pumpId);
  Future<PumpStatus> getPumpStatus(String pumpId);
  Future<void> togglePumpStatus(String pumpId, String status);
}


@Riverpod(keepAlive: true)
PumpStatusRepository pumpStatusRepository(PumpStatusRepositoryRef ref) {
  return FakePumpStatusRepository();
  // todo replace with real implementation
}

@riverpod
Stream<PumpStatus> pumpStatusStream(PumpStatusStreamRef ref, String pumpId) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.watchPumpStatus(pumpId);
}

@riverpod
Future<PumpStatus> pumpStatusFuture(PumpStatusFutureRef ref, String pumpId) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.getPumpStatus(pumpId);
}

@riverpod
Future<void> pumpStatusToggle(PumpStatusToggleRef ref, String pumpId, String status) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.togglePumpStatus(pumpId, status);
}
