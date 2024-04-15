// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      id: json['id'] as String,
      name: json['name'] as String,
      model: json['model'] as String,
      serialNumber: json['serial_number'] as String,
      collectorId: json['collector_id'] as String,
      companyId: json['company_id'] as String,
      mqttMsgName: json['mqtt_msg_name'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'model': instance.model,
      'serial_number': instance.serialNumber,
      'collector_id': instance.collectorId,
      'company_id': instance.companyId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'mqtt_msg_name': instance.mqttMsgName,
    };
