import 'package:collection/collection.dart';

import 'package:irrigazione_iot/src/config/mock/fake_sectors_status.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_status_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/domain/sector_status.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeSectorStatusRepository implements SectorStatusRepository {
  FakeSectorStatusRepository({this.addDelay = true});
  final bool addDelay;

  final _sectorStatusState =
      InMemoryStore<List<SectorStatus>>(kFakeSectorStatus);
  @override
  Future<DateTime?> getSectorLastIrrigation(Sector sector) async {
    await delay(addDelay);
    return Future.value(
      _getMostRecentIrrigationDate(_sectorStatusState.value, sector),
    );
  }

  @override
  Future<SectorStatus?> getSectorStatus(SectorID sectorID) async {
    await delay(addDelay);
    return Future.value(
      _getMostRecentStatus(_sectorStatusState.value, sectorID),
    );
  }

  @override
  Future<void> toggleSectorStatus(Sector sector, String status) async {
    await delay(addDelay);
    final statusIsValid =
        status == sector.turnOffCommand || status == sector.turnOnCommand;
    if (!statusIsValid) return;
    final sectorStatuses = [..._sectorStatusState.value];

    sectorStatuses.add(
      SectorStatus(
        sectorId: sector.id,
        status: status,
        when: DateTime.now(),
      ),
    );
    _sectorStatusState.value = sectorStatuses;
  }

  @override
  Stream<DateTime?> watchSectorLastIrrigation(Sector sector) {
    return _sectorStatusState.stream.map((statuses) {
      return _getMostRecentIrrigationDate(statuses, sector);
    });
  }

  @override
  Stream<SectorStatus?> watchSectorStatus(SectorID sectorID) {
    return _sectorStatusState.stream.map((statuses) {
      return _getMostRecentStatus(statuses, sectorID);
    });
  }

  /// * Filters the statuses for the sector
  static List<SectorStatus> _filterSectorStatus(
      List<SectorStatus> statuses, SectorID sectorID) {
    return statuses
        .where((sectorStatus) => sectorStatus.sectorId == sectorID)
        .toList();
  }

  /// * Returns the most recent status for the sector
  static SectorStatus? _getMostRecentStatus(
      List<SectorStatus> statuses, SectorID sectorId) {
    statuses.sort((a, b) => b.when.compareTo(a.when));
    final statusesForSector = _filterSectorStatus(statuses, sectorId);
    if (statusesForSector.isEmpty) return null;
    return statusesForSector.first;
  }

  /// * Returns the last time the sector was irrigated
  static DateTime? _getMostRecentIrrigationDate(
      List<SectorStatus> statuses, Sector sector) {
    statuses.sort((a, b) => b.when.compareTo(a.when));
    final statusesForSector = _filterSectorStatus(statuses, sector.id);

    return statusesForSector
        .firstWhereOrNull(
          (status) => status.translateSectorStatusToBoolean(sector) == true,
        )
        ?.when;
  }

  void dispose() => _sectorStatusState.close();
}
