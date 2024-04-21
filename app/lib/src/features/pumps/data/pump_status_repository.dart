import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'fake_pump_status_repository.dart';
import 'pump_repository.dart';
import '../model/pump.dart';

part 'pump_status_repository.g.dart';

abstract class PumpStatusRepository {
  Stream<bool?> watchPumpStatus(Pump pump);
  Future<bool?> getPumpStatus(Pump pump);
  Future<void> togglePumpStatus(Pump pump, String status);
  Stream<DateTime?> watchLastDispensation(Pump pump);
  Future<DateTime?> getLastDispensation(Pump pump);
}

@Riverpod(keepAlive: true)
PumpStatusRepository pumpStatusRepository(PumpStatusRepositoryRef ref) {
  return FakePumpStatusRepository();
  // todo replace with real implementation
}

@riverpod
Stream<bool?> pumpStatusStream(PumpStatusStreamRef ref, Pump pump) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.watchPumpStatus(pump);
}

@riverpod
Future<bool?> pumpStatusFuture(PumpStatusFutureRef ref, Pump pump) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.getPumpStatus(pump);
}

@riverpod
Future<void> pumpStatusToggle(
    PumpStatusToggleRef ref, Pump pump, String status) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.togglePumpStatus(pump, status);
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
