import '../../data/sector_pump_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connect_pumps_to_sector_controller.g.dart';

@riverpod
class ConnectPumpsToSectorController extends _$ConnectPumpsToSectorController {
  @override
  FutureOr<void> build() {
   // nothing to do here
  }

  void handleSelection(bool value, String pumpId) {
    final selectedPumpsId = [...ref.watch(selectedPumpsIdProvider)];
    final pumpIndexInList = selectedPumpsId.indexOf(pumpId);
    if (value && pumpIndexInList >= 0) return;
    if (value) {
      selectedPumpsId.add(pumpId);
      ref.read(selectedPumpsIdProvider.notifier).state = selectedPumpsId;
    } else {
      selectedPumpsId.removeAt(pumpIndexInList);
      ref.read(selectedPumpsIdProvider.notifier).state = selectedPumpsId;
    }
  }
}