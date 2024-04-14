// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectorStatus _$SectorStatusFromJson(Map<String, dynamic> json) => SectorStatus(
      id: json['id'] as String,
      sectorId: json['sector_id'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SectorStatusToJson(SectorStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sector_id': instance.sectorId,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
    };
