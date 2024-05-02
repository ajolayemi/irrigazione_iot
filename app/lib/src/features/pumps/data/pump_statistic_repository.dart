import 'package:irrigazione_iot/src/features/pumps/data/supabase_pump_statistic_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_pressure.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pump_statistic_repository.g.dart';

/// Repository to fetch pump statistics
abstract class PumpStatisticRepository {
  /// Emits the last pump pressure for the given [pumpId]
  Stream<PumpPressure?> watchLastPumpPressure(String pumpId);
}

@Riverpod(keepAlive: true)
PumpStatisticRepository pumpStatisticRepository(
    PumpStatisticRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabasePumpStatisticRepository(supabaseClient);
}

@riverpod
Stream<PumpPressure?> pumpLastPressureStream(
    PumpLastPressureStreamRef ref, String pumpId) {
  final pumpStatisticRepository = ref.read(pumpStatisticRepositoryProvider);
  return pumpStatisticRepository.watchLastPumpPressure(pumpId);
}
