import 'package:irrigazione_iot/src/features/sectors/models/sector_pressure.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/dao/app_abstract_dao.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_pressure.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_flow.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_pressure.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/features/terminal/models/terminal_pressure.dart';

part 'mqtt_dao.g.dart';

class MqttDao extends AppAbstractDao {
  Isar? get _db => dbInstance;

  /// Emits the last pressure of the sector with the provided [sectorId]
  Stream<SectorPressure?> watchSectorPressure(String? sectorId) {
    if (sectorId == null || sectorId.isEmpty) {
      return Stream.value(null);
    }

    final query =
        _db?.localSectorPressures.filter().sectorIdEqualTo(sectorId).build();
    if (query == null) {
      return Stream.value(null);
    }

    return query.watch(fireImmediately: true).map((events) {
      if (events.isEmpty) {
        return null;
      }
      final last = events.last;
      return SectorPressure.fromEntity(last);
    });
  }

  /// Emits the last pressure of the terminal with the provided [collectorId]
  Stream<TerminalPressure?> watchTerminalPressure(String? collectorId) {
    if (collectorId == null || collectorId.isEmpty) {
      return Stream.value(null);
    }

    final query = _db?.localTerminalPressures
        .filter()
        .collectorIdEqualTo(collectorId)
        .build();
    if (query == null) {
      return Stream.value(null);
    }

    return query.watch(fireImmediately: true).map((events) {
      if (events.isEmpty) {
        return null;
      }
      final last = events.last;
      return TerminalPressure.fromEntity(last);
    });
  }

  /// Emits the last pressure of the collector with the provided [collectorId]
  Stream<CollectorPressure?> watchCollectorPressure(String? collectorId) {
    if (collectorId == null || collectorId.isEmpty) {
      return Stream.value(null);
    }

    final query = _db?.localCollectorPressures
        .filter()
        .collectorIdEqualTo(collectorId)
        .build();
    if (query == null) {
      return Stream.value(null);
    }

    return query.watch(fireImmediately: true).map((events) {
      if (events.isEmpty) {
        return null;
      }
      final last = events.last;
      return CollectorPressure.fromEntity(last);
    });
  }

  /// Emits the last pressure of the pump with the provided [pumpId]
  Stream<PumpPressure?> watchPumpPressure(String? pumpId) {
    if (pumpId == null || pumpId.isEmpty) {
      return Stream.value(null);
    }

    final query =
        _db?.localPumpPressures.filter().pumpIdEqualTo(pumpId).build();
    if (query == null) {
      return Stream.value(null);
    }

    return query.watch(fireImmediately: true).map((events) {
      if (events.isEmpty) {
        return null;
      }
      final last = events.last;
      return PumpPressure.fromEntity(last);
    });
  }

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

    final query = _db?.localPumpFlows.filter().pumpIdEqualTo(pumpId).build();
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
    final query = _db?.localSectorSwitchedOns.filter().item((q) {
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
    final query = _db?.localPumpSwitchedOns.filter().item((q) {
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
    final query = _db?.localSectorStatus.filter().status((q) {
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
    final query = _db?.localPumpStatus.filter().status((q) {
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

  Future<void> insertSectorPressures({
    required List<SectorPressure> data,
  }) async {
    if (data.isEmpty) {
      return;
    }

    await _db?.writeTxn(
      () async => await _db?.localSectorPressures.putAll(
        data.toEntities(),
      ),
    );
  }

  Future<void> insertTerminalPressures({
    required List<TerminalPressure> data,
  }) async {
    if (data.isEmpty) {
      return;
    }

    await _db?.writeTxn(
      () async => await _db?.localTerminalPressures.putAll(
        data.toEntities(),
      ),
    );
  }

  Future<void> insertCollectorPressures({
    required List<CollectorPressure> data,
  }) async {
    if (data.isEmpty) {
      return;
    }

    await _db?.writeTxn(
      () async => await _db?.localCollectorPressures.putAll(
        data.toEntities(),
      ),
    );
  }

  Future<void> insertPumpPressures({
    required List<PumpPressure> data,
  }) async {
    if (data.isEmpty) {
      return;
    }

    await _db?.writeTxn(
      () async => await _db?.localPumpPressures.putAll(
        data.toEntity(),
      ),
    );
  }

  Future<void> insertPumpFlows({
    required List<PumpFlow> data,
  }) async {
    if (data.isEmpty) {
      return;
    }

    await _db?.writeTxn(
      () async => await _db?.localPumpFlows.putAll(
        data.toEntity(),
      ),
    );
  }

  Future<void> insertPumpsSwitchedOn({
    required List<PumpSwitchedOn> data,
  }) async {
    if (data.isEmpty) {
      return;
    }

    await _db?.writeTxn(
      () async => await _db?.localPumpSwitchedOns.putAll(
        data.toEntities(),
      ),
    );
  }

  Future<void> insertSectorsSwitchedOn({
    required List<SectorSwitchedOn> data,
  }) async {
    if (data.isEmpty) return;

    await _db?.writeTxn(
      () async => await _db?.localSectorSwitchedOns.putAll(
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
      () async => await _db?.localPumpStatus.putAll(
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
      () async => await _db?.localSectorStatus.putAll(
        statuses.toMqttStatuses(),
      ),
    );
  }

  Future<void> clearMqttDao() async {
    await _db?.writeTxn(() async {
      await _db?.clear();
    });
  }
}

@Riverpod(keepAlive: true)
MqttDao mqttDao(MqttDaoRef ref) {
  return MqttDao();
}
