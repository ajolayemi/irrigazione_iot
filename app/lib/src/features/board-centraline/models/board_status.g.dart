// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardStatus _$BoardStatusFromJson(Map<String, dynamic> json) => BoardStatus(
      id: json['id'] as String,
      batteryLevel: (json['battery_level'] as num).toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      boardId: json['board_id'] as String,
    );

Map<String, dynamic> _$BoardStatusToJson(BoardStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'battery_level': instance.batteryLevel,
      'created_at': instance.createdAt?.toIso8601String(),
      'board_id': instance.boardId,
    };
