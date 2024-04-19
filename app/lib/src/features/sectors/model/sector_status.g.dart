// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectorStatus _$SectorStatusFromJson(Map<String, dynamic> json) => SectorStatus(
      id: const IntConverter().fromJson(json['id'] as int),
      sectorId: const IntConverter().fromJson(json['sector_id'] as int),
      status: json['status'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SectorStatusToJson(SectorStatus instance) =>
    <String, dynamic>{
      'sector_id': const IntConverter().toJson(instance.sectorId),
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
    };
