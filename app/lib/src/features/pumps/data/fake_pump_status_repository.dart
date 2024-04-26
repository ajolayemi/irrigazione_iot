import 'package:irrigazione_iot/src/config/mock/fake_pump_status.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakePumpStatusRepository extends PumpStatusRepository {
  FakePumpStatusRepository({this.addDelay = true});
  final bool addDelay;
  final _fakePumpStatus = InMemoryStore<List<PumpStatus>>(kFakePumpStatus);


  static PumpStatus _getMostRecentStatus(List<PumpStatus> statuses) {
    statuses.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return statuses.first;
  }

  static List<PumpStatus> _filterPumpStatus(
      List<PumpStatus> statuses, String pumpId) {
    final toReturn =
        statuses.where((pumpStatus) => pumpStatus.pumpId == pumpId).toList();
    return toReturn;
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

    final matchingPump = kFakePumps.firstWhere((element) => element.id == pump.id);

    final lastSectorId = _fakePumpStatus.value
        .map((sector) => int.tryParse(sector.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);
    // Then add a new status value for the said pump
    pumpStatuses.add(
      PumpStatus(
        id: '${lastSectorId + 1}',
        status: status,
        createdAt: DateTime.now(),
        pumpId: pump.id,
        statusBoolean: status == matchingPump.turnOnCommand,
      ),
    );
    _fakePumpStatus.value = pumpStatuses;
  }

  void dispose() => _fakePumpStatus.close();
}
