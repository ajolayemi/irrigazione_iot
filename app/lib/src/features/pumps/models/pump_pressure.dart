// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'pump_pressure.g.dart';

@JsonSerializable()
class PumpPressure extends Equatable {
  const PumpPressure({
    this.id,
    this.pumpId,
    this.filterInPressure,
    this.filterOutPressure,
    this.createdAt,
  }) : pressureDifference = (filterInPressure ?? 0) - (filterOutPressure ?? 0);

  @JsonKey(name: PumpPressureDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String? id;

  @JsonKey(name: PumpPressureDatabaseKeys.pumpId)
  @IntConverter()
  final String? pumpId;

  @JsonKey(name: PumpPressureDatabaseKeys.filterInPressure)
  final double? filterInPressure;

  @JsonKey(name: PumpPressureDatabaseKeys.filterOutPressure)
  final double? filterOutPressure;

  @JsonKey(name: PumpPressureDatabaseKeys.pressureDifference)
  final double? pressureDifference;

  @JsonKey(name: PumpPressureDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props {
    return [
      id,
      pumpId,
      filterInPressure,
      filterOutPressure,
      pressureDifference,
      createdAt,
    ];
  }

  factory PumpPressure.fromJson(Map<String, dynamic> json) =>
      _$PumpPressureFromJson(json);

  Map<String, dynamic> toJson() => _$PumpPressureToJson(this);

  factory PumpPressure.fromEntity(LocalPumpPressure? entity) {
    return PumpPressure(
      id: entity?.id.toString() ?? '',
      pumpId: entity?.pumpId ?? '',
      filterInPressure: entity?.filterInPressure ?? 0,
      filterOutPressure: entity?.filterOutPressure ?? 0,
      createdAt: entity?.createdAt,
    );
  }

  factory PumpPressure.fromMqttMsg(
    PumpPressureFromMqtt? mqttMsg, {
    String? pumpId,
    DateTime? createdAt,
  }) {
    return PumpPressure(
      pumpId: pumpId,
      createdAt: createdAt,
      filterInPressure: mqttMsg?.filterInPressure,
      filterOutPressure: mqttMsg?.filterOutPressure,
    );
  }

  LocalPumpPressure toEntity() {
    return LocalPumpPressure()
      ..createdAt = createdAt
      ..filterInPressure = filterInPressure
      ..filterOutPressure = filterOutPressure
      ..pumpId = pumpId
      ..pressureDifference = pressureDifference
      ..id = int.tryParse(id ?? '');
  }
}

/// Representation of a pump pressure message as received from
@JsonSerializable(explicitToJson: true)
class PumpPressureFromMqtt {
  @JsonKey(name: 'IN_CH1')
  final double? filterInPressure;

  @JsonKey(name: 'OUT_CH2')
  final double? filterOutPressure;

  @JsonKey(name: 'type')
  final String? msgType;

  @JsonKey(name: 'name')
  final String? mqttName;

  const PumpPressureFromMqtt({
    this.filterInPressure,
    this.filterOutPressure,
    this.msgType,
    this.mqttName,
  });

  factory PumpPressureFromMqtt.fromJson(Map<String, dynamic> json) =>
      _$PumpPressureFromMqttFromJson(json);

  Map<String, dynamic> toJson() => _$PumpPressureFromMqttToJson(this);
}

extension PumpPressureListX on List<PumpPressure> {
  List<LocalPumpPressure> toEntity() {
    return map((e) => e.toEntity()).toList();
  }
}
