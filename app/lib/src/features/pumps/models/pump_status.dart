import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/pump_switched_on.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'pump_status.g.dart';

@JsonSerializable()
class PumpStatus extends Equatable {
  const PumpStatus({
    required this.id,
    required this.pumpId,
    required this.status,
    required this.statusBoolean,
    required this.companyId,
    this.createdAt,
  });

  @JsonKey(name: PumpStatusDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: PumpStatusDatabaseKeys.pumpId)
  @IntConverter()
  final String pumpId;

  @JsonKey(name: PumpStatusDatabaseKeys.companyId)
  @IntConverter()
  final String companyId;

  @JsonKey(name: PumpStatusDatabaseKeys.status)
  final String status;

  @JsonKey(name: PumpStatusDatabaseKeys.statusBoolean)
  final bool statusBoolean;

  @JsonKey(name: PumpStatusDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, pumpId, status, createdAt];

  factory PumpStatus.fromJson(Map<String, dynamic> json) =>
      _$PumpStatusFromJson(json);

  Map<String, dynamic> toJson() => _$PumpStatusToJson(this);

  factory PumpStatus.fromEntity(MqttPumpStatus? entity) {
    return PumpStatus(
      companyId: entity?.status?.companyId ?? '',
      id: entity?.id.toString() ?? '',
      pumpId: entity?.status?.itemId ?? '',
      status: entity?.status?.status ?? '',
      statusBoolean: entity?.status?.statusBoolean ?? false,
      createdAt: entity?.status?.createdAt,
    );
  }

  MqttPumpStatus toEntity() {
    final mqttStatus = MqttStatus()
      ..companyId = companyId
      ..itemId = pumpId
      ..status = status
      ..statusBoolean = statusBoolean
      ..createdAt = createdAt;
    return MqttPumpStatus()
      ..status = mqttStatus
      ..id = int.tryParse(id);
  }
}

extension PumpStatusesEx on List<PumpStatus> {
  List<MqttPumpStatus> toMqttStatuses() {
    return map((e) => e.toEntity()).toList();
  }

  List<PumpSwitchedOn> toPumpsSwitchedOn() {
    return map((e) => PumpSwitchedOn.fromPumpStatus(e)).toList();
  }
}
