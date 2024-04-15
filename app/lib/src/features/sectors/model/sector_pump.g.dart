// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_pump.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectorPump _$SectorPumpFromJson(Map<String, dynamic> json) => SectorPump(
      id: json['id'] as String,
      sectorId: json['sector_id'] as String,
      pumpId: json['pump_id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SectorPumpToJson(SectorPump instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sector_id': instance.sectorId,
      'pump_id': instance.pumpId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
