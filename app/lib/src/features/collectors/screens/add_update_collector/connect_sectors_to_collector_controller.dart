import 'package:irrigazione_iot/src/features/collectors/providers/selected_sectors_id_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connect_sectors_to_collector_controller.g.dart';

@riverpod
class ConnectSectorsToCollectorController
    extends _$ConnectSectorsToCollectorController {
  @override
  FutureOr<void> build() {}

  void handleSelection({
    required bool value,
    required String sectorId,
  }) {
    final selectedSectorsId = ref.read(selectedSectorsIdProvider);
    final sectorIndexInList = selectedSectorsId.indexOf(sectorId);
    if (value && sectorIndexInList >= 0) return;
    if (value) {
      ref.read(selectedSectorsIdProvider.notifier).add(sectorId);
    } else {
      selectedSectorsId.removeAt(sectorIndexInList);
      ref
          .read(selectedSectorsIdProvider.notifier)
          .removeAtIndex(sectorId, sectorIndexInList);
    }
  }
}
