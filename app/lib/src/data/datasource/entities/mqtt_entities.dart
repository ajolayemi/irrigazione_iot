import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_flow.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:isar/isar.dart';

part 'mqtt_entities.g.dart';




@collection
class MqttPumpFlow {
  Id? id;

  String? pumpId;

  double? flow;

  double? litresPerSecond;

  DateTime? createdAt;
}

@collection
class MqttPumpStatus {
  Id? id;

  MqttStatus? status;
}

@collection
class MqttSectorStatus {
  Id? id;

  MqttStatus? status;
}

@collection
class MqttPumpSwitchedOn {
  /// Item id to be used as unique identifier
  Id? id;

  MqttItemSwitchedOn? item;
}

@collection
class MqttSectorSwitchedOn {
  Id? id;

  MqttItemSwitchedOn? item;
}

@embedded
class MqttItemSwitchedOn {
  bool? statusBoolean;

  String? companyId;
}

@embedded
class MqttStatus {
  /// A string identifying the command necessary for identity the
  /// current status of an item
  String? status;

  bool? statusBoolean;

  String? companyId;

  DateTime? createdAt;

  String? itemId;
}

extension MqttPumpStatusExt on List<MqttPumpStatus> {
  List<PumpStatus> toModel() {
    return map((e) => PumpStatus.fromEntity(e)).toList();
  }
}

extension MqttSectorStatusExt on List<MqttSectorStatus> {
  List<SectorStatus> toModel() {
    return map((e) => SectorStatus.fromEntity(e)).toList();
  }
}

extension PumpsSwitchedOnExt on List<MqttPumpSwitchedOn> {
  List<PumpSwitchedOn> toModel() {
    return map((e) => PumpSwitchedOn.fromEntity(e)).toList();
  }
}

extension SectorsSwitchedOnExt on List<MqttSectorSwitchedOn> {
  List<SectorSwitchedOn> toModel() {
    return map((e) => SectorSwitchedOn.fromEntity(e)).toList();
  }
}

extension MqttPumpFlowExt on List<MqttPumpFlow> {
  List<PumpFlow> toModel() {
    return map((e) => PumpFlow.fromEntity(e)).toList();
  }
}