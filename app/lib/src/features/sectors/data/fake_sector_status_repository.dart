import 'package:collection/collection.dart';

import '../../../config/mock/fake_sectors_status.dart';
import 'sector_status_repository.dart';
import '../model/sector.dart';
import '../model/sector_status.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';

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
  Future<bool?> getSectorStatus(Sector sector) async {
    await delay(addDelay);
    final mostRecentStatus =
        _getMostRecentStatus(_sectorStatusState.value, sector.id);
    return Future.value(
      mostRecentStatus?.translateSectorStatusToBoolean(sector),
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
  Stream<bool?> watchSectorStatus(Sector sector) {
    return _sectorStatusState.stream.map((statuses) {
      final mostRecentStatus = _getMostRecentStatus(statuses, sector.id);
      return mostRecentStatus?.translateSectorStatusToBoolean(sector);
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
