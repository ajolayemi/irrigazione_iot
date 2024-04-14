// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector_sector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectorSector _$CollectorSectorFromJson(Map<String, dynamic> json) =>
    CollectorSector(
      id: json['id'] as String,
      collectorId: json['collector_id'] as String,
      sectorId: json['sector_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CollectorSectorToJson(CollectorSector instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collector_id': instance.collectorId,
      'sector_id': instance.sectorId,
      'created_at': instance.createdAt.toIso8601String(),
    };
