import '../../data/collector_sector_repository.dart';
import '../../../sectors/model/sector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connect_sectors_to_collector_controller.g.dart';

@riverpod
class ConnectSectorsToCollectorController
    extends _$ConnectSectorsToCollectorController {
  @override
  FutureOr<void> build() {}

  void handleSelection({
    required bool value,
    required SectorID sectorId,
  }) {
    final selectedSectorsId = [...ref.watch(selectedSectorsIdProvider)];
    final sectorIndexInList = selectedSectorsId.indexOf(sectorId);
    if (value && sectorIndexInList >= 0) return;
    if (value) {
      selectedSectorsId.add(sectorId);
      ref.read(selectedSectorsIdProvider.notifier).state = selectedSectorsId;
    } else {
      selectedSectorsId.removeAt(sectorIndexInList);
      ref.read(selectedSectorsIdProvider.notifier).state = selectedSectorsId;
    }
  }
}
