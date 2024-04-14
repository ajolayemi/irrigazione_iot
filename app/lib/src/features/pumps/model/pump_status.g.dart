// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PumpStatus _$PumpStatusFromJson(Map<String, dynamic> json) => PumpStatus(
      id: json['id'] as String,
      pumpId: json['pumpId'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PumpStatusToJson(PumpStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pumpId': instance.pumpId,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };
