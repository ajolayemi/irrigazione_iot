import 'package:irrigazione_iot/src/config/mock/fake_pump_status.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakePumpStatusRepository extends PumpStatusRepository {
  FakePumpStatusRepository({this.addDelay = true});
  final bool addDelay;
  final _fakePumpStatus = InMemoryStore<List<PumpStatus>>(kFakePumpStatus);

  static DateTime? _getMostRecentDispensationDate(
      List<PumpStatus> statuses, Pump pump) {
    statuses.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
    final statusesForPump = _filterPumpStatus(statuses, pump.id);
    try {
      return statusesForPump
          .firstWhere((status) =>
              status.translatePumpStatusToBoolean(pump) == true)
          .lastUpdated;
    } catch (e) {
      return null;
    }
  }

  static PumpStatus _getMostRecentStatus(List<PumpStatus> statuses) {
    statuses.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
    return statuses.first;
  }

  static List<PumpStatus> _filterPumpStatus(
      List<PumpStatus> statuses, PumpID pumpId) {
    final toReturn =
        statuses.where((pumpStatus) => pumpStatus.pumpId == pumpId).toList();
    return toReturn;
  }

  @override
  Future<bool?> getPumpStatus(Pump pump) async {
    await delay(addDelay);
    final statusesForPump = _filterPumpStatus(_fakePumpStatus.value, pump.id);
    if (statusesForPump.isEmpty) return Future.value(null);
    final mostRecentStatus = _getMostRecentStatus(statusesForPump);
    return Future.value(mostRecentStatus.translatePumpStatusToBoolean(pump));
  }

  @override
  Stream<bool?> watchPumpStatus(Pump pump) {
    return _fakePumpStatus.stream.map((statuses) {
      final statusesForPump = _filterPumpStatus(statuses, pump.id);
      if (statusesForPump.isEmpty) return null;
      final mostRecentStatus = _getMostRecentStatus(statusesForPump);
      return mostRecentStatus.translatePumpStatusToBoolean(pump);
    });
  }

  @override
  Future<void> togglePumpStatus(Pump pump, String status) async {
    await delay(addDelay);
    // First get the current statuses data for all pumps
    final pumpStatuses = _fakePumpStatus.value;
    // Then add a new status value for the said pump
    pumpStatuses.add(
      PumpStatus(
        status: status,
        lastUpdated: DateTime.now(),
        pumpId: pump.id,
      ),
    );
    _fakePumpStatus.value = pumpStatuses;
  }

  @override
  Future<DateTime?> getLastDispensation(Pump pump) {
    return Future.value(
      _getMostRecentDispensationDate(_fakePumpStatus.value, pump),
    );
  }

  @override
  Stream<DateTime?> watchLastDispensation(Pump pump) {
    return _fakePumpStatus.stream.map((statuses) {
      return _getMostRecentDispensationDate(statuses, pump);
    });
  }

  void dispose() => _fakePumpStatus.close();
}
