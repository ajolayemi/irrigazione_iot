// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_pressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectorPressure _$SectorPressureFromJson(Map<String, dynamic> json) =>
    SectorPressure(
      id: const IntConverter().fromJson(json['id'] as int),
      sectorId: const IntConverter().fromJson(json['sector_id'] as int),
      pressure: (json['pressure'] as num).toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SectorPressureToJson(SectorPressure instance) =>
    <String, dynamic>{
      'sector_id': const IntConverter().toJson(instance.sectorId),
      'pressure': instance.pressure,
      'created_at': instance.createdAt?.toIso8601String(),
    };
