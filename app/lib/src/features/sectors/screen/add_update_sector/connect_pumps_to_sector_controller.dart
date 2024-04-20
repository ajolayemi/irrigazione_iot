import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/data/sector_pump_repository.dart';

part 'connect_pumps_to_sector_controller.g.dart';

@riverpod
class ConnectPumpsToSectorController extends _$ConnectPumpsToSectorController {
  @override
  FutureOr<void> build() {
    // nothing to do here
  }

  void handleSelection(RadioButtonItem? newValue) {
    ref.read(selectPumpRadioButtonProvider.notifier).state = newValue;
  }
}
