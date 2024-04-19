// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_pump.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectorPump _$SectorPumpFromJson(Map<String, dynamic> json) => SectorPump(
      id: const IntConverter().fromJson(json['id'] as int),
      sectorId: const IntConverter().fromJson(json['sector_id'] as int),
      pumpId: const IntConverter().fromJson(json['pump_id'] as int),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SectorPumpToJson(SectorPump instance) =>
    <String, dynamic>{
      'sector_id': const IntConverter().toJson(instance.sectorId),
      'pump_id': const IntConverter().toJson(instance.pumpId),
      'created_at': instance.createdAt?.toIso8601String(),
    };
