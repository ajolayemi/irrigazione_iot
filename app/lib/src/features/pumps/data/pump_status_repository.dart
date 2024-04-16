import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

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
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabasePumpStatusRepository(supabaseClient);
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
    LastDispensationStreamRef ref, String pumpId) {
  final pump = ref.watch(pumpStreamProvider(pumpId)).value;
  if (pump == null) return const Stream.empty();
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.watchLastDispensation(pump);
}

@riverpod
Future<DateTime?> lastDispensationFuture(
    LastDispensationFutureRef ref, String pumpId) {
  final pump = ref.watch(pumpFutureProvider(pumpId)).value;
  if (pump == null) return Future.value(null);
  final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
  return pumpStatusRepository.getLastDispensation(pump);
}
