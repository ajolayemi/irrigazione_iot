// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_pressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PumpPressure _$PumpPressureFromJson(Map<String, dynamic> json) => PumpPressure(
      id: json['id'] as String,
      pumpId: json['pump_id'] as String,
      filterInPressure: (json['filter_in_pressure'] as num).toDouble(),
      filterOutPressure: (json['filter_out_pressure'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PumpPressureToJson(PumpPressure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pump_id': instance.pumpId,
      'filter_in_pressure': instance.filterInPressure,
      'filter_out_pressure': instance.filterOutPressure,
      'created_at': instance.createdAt.toIso8601String(),
    };
