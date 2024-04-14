// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector_pressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectorPressure _$CollectorPressureFromJson(Map<String, dynamic> json) =>
    CollectorPressure(
      id: json['id'] as String,
      filterInPressure: (json['filter_in_pressure'] as num).toDouble(),
      filterOutPressure: (json['filter_out_pressure'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      collectorId: json['collector_id'] as String,
    );

Map<String, dynamic> _$CollectorPressureToJson(CollectorPressure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filter_in_pressure': instance.filterInPressure,
      'filter_out_pressure': instance.filterOutPressure,
      'created_at': instance.createdAt.toIso8601String(),
      'collector_id': instance.collectorId,
    };
