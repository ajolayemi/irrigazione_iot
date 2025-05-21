import 'package:irrigazione_iot/src/data/datasource/dao/app_abstract_dao.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mqtt_dao.g.dart';

class MqttDao extends AppAbstractDao {
  Isar? get _db => dbInstance;

  Stream<List<PumpSwitchedOn>?> watchPumpsSwitchedOn({
    String? companyId,
    bool status = true,
  }) {
    if (companyId == null || companyId.isEmpty) {
      return Stream.value(null);
    }
    final query = _db?.mqttPumpSwitchedOns.filter().item((q) {
      return q.companyIdEqualTo(companyId).statusBooleanEqualTo(status);
    }).build();

    if (query == null) {
      return Stream.value(null);
    }

    return query.watch(fireImmediately: true).map((events) {
      if (events.isEmpty) {
        return null;
      }

      return events.toModel();
    });
  }

  Stream<PumpStatus?> watchPumpStatus(
    String pumpId,
  ) {
    final query = _db?.mqttPumpStatus.filter().status((q) {
      return q.itemIdEqualTo(pumpId);
    }).build();
    if (query == null) {
      return Stream.value(null);
    }
    return query.watch(fireImmediately: true).map((events) {
      if (events.isEmpty) {
        return null;
      }
      final last = events.last;
      return PumpStatus.fromEntity(last);
    });
  }

  Future<void> insertPumpsSwitchedOn({
    required List<PumpSwitchedOn> data,
  }) async {
    if (data.isEmpty) {
      return;
    }

    await _db?.writeTxn(
      () async => await _db?.mqttPumpSwitchedOns.putAll(
        data.toEntities(),
      ),
    );
  }

  Future<void> insertPumpStatuses({
    required List<PumpStatus> statuses,
  }) async {
    if (statuses.isEmpty) {
      return;
    }

    await _db?.writeTxn(
      () async => await _db?.mqttPumpStatus.putAll(
        statuses.toMqttStatuses(),
      ),
    );
  }

  Future<void> clearMqttStatus() async {
    await _db?.writeTxn(() async {
      await _db?.mqttPumpStatus.clear();
    });
  }
}

@Riverpod(keepAlive: true)
MqttDao mqttDao(MqttDaoRef ref) {
  return MqttDao();
}
