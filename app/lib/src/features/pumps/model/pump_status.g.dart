// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PumpStatus _$PumpStatusFromJson(Map<String, dynamic> json) => PumpStatus(
      id: const IntConverter().fromJson(json['id'] as int),
      pumpId: const IntConverter().fromJson(json['pump_id'] as int),
      status: json['status'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PumpStatusToJson(PumpStatus instance) =>
    <String, dynamic>{
      'pump_id': const IntConverter().toJson(instance.pumpId),
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
    };
