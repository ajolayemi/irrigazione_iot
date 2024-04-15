// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal_pressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminalPressure _$TerminalPressureFromJson(Map<String, dynamic> json) =>
    TerminalPressure(
      id: json['id'] as String,
      collectorId: json['collector_id'] as String,
      pressure: (json['pressure'] as num).toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TerminalPressureToJson(TerminalPressure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collector_id': instance.collectorId,
      'pressure': instance.pressure,
      'created_at': instance.createdAt?.toIso8601String(),
    };
