import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';

class PumpStatusSwitchControllerState {
  const PumpStatusSwitchControllerState({required this.loadingStates});

  final Map<String, bool> loadingStates;

  bool isLoading(String pumpId) => loadingStates[pumpId] ?? false;

  bool aPumpIsLoading() {
    return loadingStates.values.any((element) => element);
  }

  // Helper methods to manipulate the loading states
  PumpStatusSwitchControllerState setLoading(String pumpId, bool isLoading) {
    return PumpStatusSwitchControllerState(
      loadingStates: Map.from(loadingStates)..[pumpId] = isLoading,
    );
  }
}

class PumpLoadingStateNotifier
    extends StateNotifier<PumpStatusSwitchControllerState> {
  PumpLoadingStateNotifier(this.ref)
      : super(const PumpStatusSwitchControllerState(loadingStates: {}));

  final Ref ref;
  void setLoading(String pumpId, bool isLoading) {
    state = state.setLoading(pumpId, isLoading);
  }

  bool isLoading(String pumpId) {
    return state.isLoading(pumpId);
  }

  Future<void> toggleStatus(Pump pump, bool status) async {
    state = state.setLoading(pump.id, true);
    final statusCommand = pump.getStatusCommand(status);
    final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);

    try {
      await pumpStatusRepository.togglePumpStatus(pump.id, statusCommand);
    } finally {
      state = state.setLoading(pump.id, false);
    }
  }
}

final pumpStatusSwitchControllerProvider = StateNotifierProvider.autoDispose<
    PumpLoadingStateNotifier, PumpStatusSwitchControllerState>((ref) {
  return PumpLoadingStateNotifier(ref);
});



// // todo remove this

// @riverpod
// class PumpStatusSwitchController extends _$PumpStatusSwitchController {
//   @override
//   FutureOr<void> build() {
//     //
//   }

//   Future<void> toggleStatus(Pump pump, bool status) async {
//     state = const AsyncLoading();
//     final statusCommand = pump.getStatusCommand(status);
//     final pumpStatusRepository = ref.watch(pumpStatusRepositoryProvider);
//     state = await AsyncValue.guard(
//         () => pumpStatusRepository.togglePumpStatus(pump.id, statusCommand));
//   }
// }
