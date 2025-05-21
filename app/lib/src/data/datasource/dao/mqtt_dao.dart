import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/dao/app_abstract_dao.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_flow.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';

part 'mqtt_dao.g.dart';

class MqttDao extends AppAbstractDao {
  Isar? get _db => dbInstance;

  /// Emits the last time the pump with the provided [pumpId] dispensed water
  Stream<DateTime?> watchPumpLastDispensation(String? pumpId) {
    return watchPumpFlow(pumpId).map((event) {
      if (event == null) {
        return null;
      }
      return event.createdAt;
    });
  }

  /// Emits the last [PumpFlow] of the pump with the provided [pumpId]
  Stream<PumpFlow?> watchPumpFlow(String? pumpId) {
    if (pumpId == null || pumpId.isEmpty) {
      return Stream.value(null);
    }

    final query = _db?.mqttPumpFlows.filter().pumpIdEqualTo(pumpId).build();
    if (query == null) {
      return Stream.value(null);
    }

    return query.watch(fireImmediately: true).map((events) {
      if (events.isEmpty) {
        return null;
      }
      final last = events.last;
      return PumpFlow.fromEntity(last);
    });
  }

  Stream<List<SectorSwitchedOn>?> watchSectorsSwitchedOn({
    String? companyId,
    bool status = true,
  }) {
    if (companyId == null || companyId.isEmpty) {
      return Stream.value(null);
    }
    final query = _db?.mqttSectorSwitchedOns.filter().item((q) {
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

  Stream<SectorStatus?> watchSectorStatus(String sectorId) {
    final query = _db?.mqttSectorStatus.filter().status((q) {
      return q.itemIdEqualTo(sectorId);
    }).build();
    if (query == null) {
      return Stream.value(null);
    }
    return query.watch(fireImmediately: true).map((events) {
      if (events.isEmpty) {
        return null;
      }
      final last = events.last;
      return SectorStatus.fromEntity(last);
    });
  }

  Stream<PumpStatus?> watchPumpStatus(String pumpId) {
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

  Future<void> insertSectorsSwitchedOn({
    required List<SectorSwitchedOn> data,
  }) async {
    if (data.isEmpty) return;

    await _db?.writeTxn(
      () async => await _db?.mqttSectorSwitchedOns.putAll(
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

  Future<void> insertSectorStatuses({
    required List<SectorStatus> statuses,
  }) async {
    if (statuses.isEmpty) {
      return;
    }

    await _db?.writeTxn(
      () async => await _db?.mqttSectorStatus.putAll(
        statuses.toMqttStatuses(),
      ),
    );
  }

  Future<void> clearMqttDao() async {
    await _db?.writeTxn(() async {
      await _db?.mqttPumpStatus.clear();
      await _db?.mqttPumpSwitchedOns.clear();
      await _db?.mqttSectorStatus.clear();
      await _db?.mqttSectorSwitchedOns.clear();
    });
  }
}

@Riverpod(keepAlive: true)
MqttDao mqttDao(MqttDaoRef ref) {
  return MqttDao();
}
