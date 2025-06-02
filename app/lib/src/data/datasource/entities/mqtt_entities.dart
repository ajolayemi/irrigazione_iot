import 'package:isar/isar.dart';

import 'package:irrigazione_iot/src/features/collectors/models/collector_pressure.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_flow.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_pressure.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pressure.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/features/terminal/models/terminal_pressure.dart';

part 'mqtt_entities.g.dart';

@collection
class LocalSectorPressure {
  Id? id;

  double? pressure;

  String? sectorId;

  DateTime? createdAt;
}

@collection
class LocalTerminalPressure {
  Id? id;

  String? collectorId;

  double? pressure;

  DateTime? createdAt;
}

@collection
class LocalCollectorPressure {
  Id? id;

  String? collectorId;

  double? filterInPressure;

  double? filterOutPressure;

  double? pressureDifference;

  DateTime? createdAt;
}

@collection
class LocalPumpPressure {
  Id? id;

  String? pumpId;

  double? filterInPressure;

  double? filterOutPressure;

  double? pressureDifference;

  DateTime? createdAt;
}

@collection
class LocalPumpFlow {
  Id? id;

  String? pumpId;

  double? flow;

  double? litresPerSecond;

  DateTime? createdAt;
}

@collection
class LocalPumpStatus {
  Id? id;

  LocalStatus? status;
}

@collection
class LocalSectorStatus {
  Id? id;

  LocalStatus? status;
}

@collection
class LocalPumpSwitchedOn {
  /// Item id to be used as unique identifier
  Id? id;

  LocalItemSwitchedOn? item;
}

@collection
class LocalSectorSwitchedOn {
  Id? id;

  LocalItemSwitchedOn? item;
}

@embedded
class LocalItemSwitchedOn {
  bool? statusBoolean;

  String? companyId;
}

@embedded
class LocalStatus {
  /// A string identifying the command necessary for identity the
  /// current status of an item
  String? status;

  bool? statusBoolean;

  String? companyId;

  DateTime? createdAt;

  String? itemId;
}

extension LocalPumpStatusExt on List<LocalPumpStatus> {
  List<PumpStatus> toModel() {
    return map((e) => PumpStatus.fromEntity(e)).toList();
  }
}

extension LocalSectorStatusExt on List<LocalSectorStatus> {
  List<SectorStatus> toModel() {
    return map((e) => SectorStatus.fromEntity(e)).toList();
  }
}

extension LocalPumpsSwitchedOnExt on List<LocalPumpSwitchedOn> {
  List<PumpSwitchedOn> toModel() {
    return map((e) => PumpSwitchedOn.fromEntity(e)).toList();
  }
}

extension LocalSectorsSwitchedOnExt on List<LocalSectorSwitchedOn> {
  List<SectorSwitchedOn> toModel() {
    return map((e) => SectorSwitchedOn.fromEntity(e)).toList();
  }
}

extension LocalPumpFlowExt on List<LocalPumpFlow> {
  List<PumpFlow> toModel() {
    return map((e) => PumpFlow.fromEntity(e)).toList();
  }
}

extension LocalPumpPressureExt on List<LocalPumpPressure> {
  List<PumpPressure> toModel() {
    return map((e) => PumpPressure.fromEntity(e)).toList();
  }
}

extension LocalCollectorPressureExt on List<LocalCollectorPressure> {
  List<CollectorPressure> toModel() {
    return map((e) => CollectorPressure.fromEntity(e)).toList();
  }
}

extension LocalTerminalPressureExt on List<LocalTerminalPressure> {
  List<TerminalPressure> toModel() {
    return map((e) => TerminalPressure.fromEntity(e)).toList();
  }
}

extension LocalSectorPressureExt on List<LocalSectorPressure> {
  List<SectorPressure> toModel() {
    return map((e) => SectorPressure.fromEntity(e)).toList();
  }
}
