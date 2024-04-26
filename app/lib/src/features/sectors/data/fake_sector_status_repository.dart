import 'package:irrigazione_iot/src/config/mock/fake_sectors.dart';
import 'package:irrigazione_iot/src/config/mock/fake_sectors_status.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeSectorStatusRepository implements SectorStatusRepository {
  FakeSectorStatusRepository({this.addDelay = true});
  final bool addDelay;

  final _sectorStatusState =
      InMemoryStore<List<SectorStatus>>(kFakeSectorStatus);
  @override
  Future<void> toggleSectorStatus(
      {required String sectorId,
      required String statusString,
      required bool statusBoolean}) async {
    await delay(addDelay);

    final sector = kFakeSectors.firstWhere((element) => element.id == sectorId);
    final statusIsValid = statusString == sector.turnOffCommand ||
        statusString == sector.turnOnCommand;
    if (!statusIsValid) return;
    final sectorStatuses = [..._sectorStatusState.value];

    final lastId = _sectorStatusState.value
        .map((status) => int.tryParse(status.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);

    sectorStatuses.add(
      SectorStatus(
        id: (lastId + 1).toString(),
        statusBoolean: statusString == sector.turnOnCommand,
        sectorId: sector.id,
        status: statusString,
        createdAt: DateTime.now(),
      ),
    );
    _sectorStatusState.value = sectorStatuses;
  }

  @override
  Stream<bool?> watchSectorStatus(String sectorId) {
    return _sectorStatusState.stream.map((statuses) {
      final mostRecentStatus = _getMostRecentStatus(statuses, sectorId);
      return mostRecentStatus?.statusBoolean;
    });
  }

  /// * Filters the statuses for the sector
  static List<SectorStatus> _filterSectorStatus(
      List<SectorStatus> statuses, String sectorID) {
    return statuses
        .where((sectorStatus) => sectorStatus.sectorId == sectorID)
        .toList();
  }

  /// * Returns the most recent status for the sector
  static SectorStatus? _getMostRecentStatus(
      List<SectorStatus> statuses, String sectorId) {
    statuses.sort((a, b) => b.createdAt?.compareTo(a.createdAt!) ?? 0);
    final statusesForSector = _filterSectorStatus(statuses, sectorId);
    if (statusesForSector.isEmpty) return null;
    return statusesForSector.first;
  }

  void dispose() => _sectorStatusState.close();
}
