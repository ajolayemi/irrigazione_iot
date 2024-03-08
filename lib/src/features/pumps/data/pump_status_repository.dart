import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_status_repository.g.dart';

abstract class PumpStatusRepository {
  Stream<PumpStatus?> watchPumpStatus(PumpID pumpId);
  Future<PumpStatus?> getPumpStatus(PumpID pumpId);
  Future<void> togglePumpStatus(PumpID pumpId, String status);
  Stream<DateTime?> watchLastDispensation(Pump pump);
  Future<DateTime?> getLastDispensation(Pump pump);
}

@Riverpod(keepAlive: true)
PumpStatusRepository pumpStatusRepository(PumpStatusRepositoryRef ref) {
  return FakePumpStatusRepository();
  // todo replace with real implementation
}

@riverpod
Stream<PumpStatus?> pumpStatusStream(PumpStatusStreamRef ref, PumpID pumpId) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.watchPumpStatus(pumpId);
}

@riverpod
Future<PumpStatus?> pumpStatusFuture(PumpStatusFutureRef ref, PumpID pumpId) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.getPumpStatus(pumpId);
}

@riverpod
Future<void> pumpStatusToggle(
    PumpStatusToggleRef ref, PumpID pumpId, String status) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.togglePumpStatus(pumpId, status);
}

@riverpod
Stream<DateTime?> lastDispensationStream(
    LastDispensationStreamRef ref, PumpID pumpId) {
  final pump = ref.watch(pumpStreamProvider(pumpId)).value;
  if (pump == null) return const Stream.empty();
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.watchLastDispensation(pump);
}

@riverpod
Future<DateTime?> lastDispensationFuture(
    LastDispensationFutureRef ref, PumpID pumpId) {
  final pump = ref.watch(pumpFutureProvider(pumpId)).value;
  if (pump == null) return Future.value(null);
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.getLastDispensation(pump);
}
