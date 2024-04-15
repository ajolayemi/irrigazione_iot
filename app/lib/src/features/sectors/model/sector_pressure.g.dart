// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_pressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectorPressure _$SectorPressureFromJson(Map<String, dynamic> json) =>
    SectorPressure(
      id: json['id'] as String,
      sectorId: json['sector_id'] as String,
      pressure: (json['pressure'] as num).toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SectorPressureToJson(SectorPressure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sector_id': instance.sectorId,
      'pressure': instance.pressure,
      'created_at': instance.createdAt?.toIso8601String(),
    };
