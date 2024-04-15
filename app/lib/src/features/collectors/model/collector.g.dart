// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collector _$CollectorFromJson(Map<String, dynamic> json) => Collector(
      id: json['id'] as String,
      name: json['name'] as String,
      connectedFilterName: json['connected_filter_name'] as String,
      companyId: json['company_id'] as String,
      mqttMsgName: json['mqtt_msg_name'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CollectorToJson(Collector instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'connected_filter_name': instance.connectedFilterName,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'company_id': instance.companyId,
      'mqtt_msg_name': instance.mqttMsgName,
    };
