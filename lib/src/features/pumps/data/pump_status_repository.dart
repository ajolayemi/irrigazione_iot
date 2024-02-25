import 'package:irrigazione_iot/src/features/pumps/data/fake_pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_status_repository.g.dart';

abstract class PumpStatusRepository {
  Stream<PumpStatus> watchPumpStatus(String pumpId);
  Future<PumpStatus> getPumpStatus(String pumpId);
  Future<void> togglePumpStatus(String pumpId, String status);
  Stream<DateTime?> watchLastDispensation(Pump pump);
  Future<DateTime?> getLastDispensation(Pump pump);
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
Future<void> pumpStatusToggle(
    PumpStatusToggleRef ref, String pumpId, String status) {
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.togglePumpStatus(pumpId, status);
}

@riverpod
Stream<DateTime?> lastDispensationStream(
    LastDispensationStreamRef ref, String pumpId) {
  final availablePumps = ref.watch(companyPumpsStreamProvider).value;
  if (availablePumps == null) return const Stream.empty();
  final pump = availablePumps.firstWhere((pump) => pump.id == pumpId);
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.watchLastDispensation(pump);
}

@riverpod
Future<DateTime?> lastDispensationFuture(
    LastDispensationFutureRef ref, String pumpId) {
  final availablePumps = ref.watch(companyPumpsStreamProvider).value;
  if (availablePumps == null) return Future.value(null);
  final pump = availablePumps.firstWhere((pump) => pump.id == pumpId);
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.getLastDispensation(pump);
}
