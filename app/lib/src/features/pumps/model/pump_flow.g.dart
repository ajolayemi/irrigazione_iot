// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_flow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PumpFlow _$PumpFlowFromJson(Map<String, dynamic> json) => PumpFlow(
      id: json['id'] as String,
      pumpId: json['pump_id'] as String,
      flow: (json['flow'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PumpFlowToJson(PumpFlow instance) => <String, dynamic>{
      'id': instance.id,
      'pump_id': instance.pumpId,
      'flow': instance.flow,
      'created_at': instance.createdAt.toIso8601String(),
    };
