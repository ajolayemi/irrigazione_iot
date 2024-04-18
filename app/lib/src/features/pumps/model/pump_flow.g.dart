// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_flow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PumpFlow _$PumpFlowFromJson(Map<String, dynamic> json) => PumpFlow(
      id: const IntConverter().fromJson(json['id'] as int),
      pumpId: const IntConverter().fromJson(json['pump_id'] as int),
      flow: (json['flow'] as num).toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PumpFlowToJson(PumpFlow instance) => <String, dynamic>{
      'pump_id': const IntConverter().toJson(instance.pumpId),
      'flow': instance.flow,
      'created_at': instance.createdAt?.toIso8601String(),
    };
