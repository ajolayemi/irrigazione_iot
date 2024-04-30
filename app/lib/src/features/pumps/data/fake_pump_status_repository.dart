import 'package:irrigazione_iot/src/config/mock/fake_pump_status.dart';
import 'package:irrigazione_iot/src/config/mock/fake_pumps.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_status_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status.dart';
import 'package:irrigazione_iot/src/shared/models/firebase_callable_function_body.dart';
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
  Stream<bool?> watchPumpStatus(String pumpId) {
    return _fakePumpStatus.stream.map((statuses) {
      final statusesForPump = _filterPumpStatus(statuses, pumpId);
      if (statusesForPump.isEmpty) return null;
      final mostRecentStatus = _getMostRecentStatus(statusesForPump);
      return mostRecentStatus.statusBoolean;
    });
  }

  @override
  Future<void> togglePumpStatus({
    required FirebaseCallableFunctionBody statusBody,
  }) async {
    await delay(addDelay);

    final pump = kFakePumps.firstWhere((element) => element.id == "1");
    // First get the current statuses data for all pumps
    final pumpStatuses = _fakePumpStatus.value;

    final lastSectorId = _fakePumpStatus.value
        .map((sector) => int.tryParse(sector.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);
    // Then add a new status value for the said pump
    pumpStatuses.add(
      PumpStatus(
        id: '${lastSectorId + 1}',
        status: statusBody.message,
        createdAt: DateTime.now(),
        pumpId: pump.id,
        statusBoolean: false,
      ),
    );
    _fakePumpStatus.value = pumpStatuses;
  }

  void dispose() => _fakePumpStatus.close();
}
