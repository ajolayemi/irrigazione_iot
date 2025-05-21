import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:isar/isar.dart';

part 'mqtt_entities.g.dart';

@collection
class MqttPumpStatus {
  Id? id;

  MqttStatus? status;
}

@collection
class MqttPumpSwitchedOn {
  /// Item id to be used as unique identifier
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

extension MqttEntitiesExt on List<MqttPumpStatus> {
  List<PumpStatus> toModel() {
    return map((e) => PumpStatus.fromEntity(e)).toList();
  }
}

extension PumpsSwitchedOnExt on List<MqttPumpSwitchedOn> {
  List<PumpSwitchedOn> toModel() {
    return map((e) => PumpSwitchedOn.fromEntity(e)).toList();
  }
}
