// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PumpStatus _$PumpStatusFromJson(Map<String, dynamic> json) => PumpStatus(
      id: const IntConverter().fromJson(json['id'] as int),
      pumpId: const IntConverter().fromJson(json['pumpId'] as int),
      status: json['status'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PumpStatusToJson(PumpStatus instance) =>
    <String, dynamic>{
      'pumpId': const IntConverter().toJson(instance.pumpId),
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
