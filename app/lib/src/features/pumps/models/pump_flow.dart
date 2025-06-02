// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_flow_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'pump_flow.g.dart';

@JsonSerializable()
class PumpFlow extends Equatable {
  const PumpFlow({
    this.id,
    this.pumpId,
    this.flow,
    this.litresPerSecond,
    this.createdAt,
  });

  @JsonKey(name: PumpFlowDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String? id;

  @JsonKey(name: PumpFlowDatabaseKeys.pumpId)
  @IntConverter()
  final String? pumpId;

  @JsonKey(name: PumpFlowDatabaseKeys.flow)
  final double? flow;

  @JsonKey(name: PumpFlowDatabaseKeys.litresPerSecond)
  final double? litresPerSecond;

  @JsonKey(name: PumpFlowDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
        pumpId,
        flow,
        createdAt,
        litresPerSecond,
      ];

  factory PumpFlow.fromJson(Map<String, dynamic> json) =>
      _$PumpFlowFromJson(json);

  Map<String, dynamic> toJson() => _$PumpFlowToJson(this);

  factory PumpFlow.fromEntity(LocalPumpFlow? entity) {
    return PumpFlow(
      id: entity?.id.toString() ?? '',
      pumpId: entity?.pumpId ?? '',
      flow: entity?.flow ?? 0.0,
      litresPerSecond: entity?.litresPerSecond ?? 0.0,
      createdAt: entity?.createdAt,
    );
  }

  factory PumpFlow.fromMqttMsg(
    PumpFlowFromMqtt? mqttMsg, {
    String? pumpId,
    DateTime? createdAt,
  }) {
    return PumpFlow(
      pumpId: pumpId,
      flow: (mqttMsg?.count ?? 0) * 100,
      createdAt: createdAt,
      litresPerSecond: mqttMsg?.litresPerSecond ?? 0.0,
    );
  }

  LocalPumpFlow toEntity() {
    return LocalPumpFlow()
      ..id = int.tryParse(id ?? '')
      ..pumpId = pumpId
      ..flow = flow
      ..litresPerSecond = litresPerSecond
      ..createdAt = createdAt;
  }
}

/// Representation of a pump flow message as received from Mqtt
@JsonSerializable(explicitToJson: true)
class PumpFlowFromMqtt {
  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'litresPerSecond')
  final double? litresPerSecond;
  @JsonKey(name: 'type')
  final String? msgType;
  @JsonKey(name: 'name')
  final String? mqttIdentifierName;

  const PumpFlowFromMqtt({
    this.count,
    this.litresPerSecond,
    this.msgType,
    this.mqttIdentifierName,
  });

  factory PumpFlowFromMqtt.fromJson(Map<String, dynamic> json) =>
      _$PumpFlowFromMqttFromJson(json);

  Map<String, dynamic> toJson() => _$PumpFlowFromMqttToJson(this);
}

extension PumpFlowListX on List<PumpFlow> {
  List<LocalPumpFlow> toEntity() {
    return map((e) => e.toEntity()).toList();
  }
}
