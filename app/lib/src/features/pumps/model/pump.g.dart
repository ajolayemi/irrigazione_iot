// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pump _$PumpFromJson(Map<String, dynamic> json) => Pump(
      id: json['id'] as String,
      name: json['name'] as String,
      capacityInVolume: (json['capacity_in_volume'] as num).toDouble(),
      consumeRateInKw: (json['consume_rate_in_kw'] as num).toDouble(),
      companyId: json['company_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      turnOnCommand: json['turn_on_command'] as String,
      turnOffCommand: json['turn_off_command'] as String,
      mqttMessageName: json['mqtt_msg_name'] as String,
      hasFilter: json['has_filter'] as bool,
    );

Map<String, dynamic> _$PumpToJson(Pump instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capacity_in_volume': instance.capacityInVolume,
      'consume_rate_in_kw': instance.consumeRateInKw,
      'company_id': instance.companyId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'turn_on_command': instance.turnOnCommand,
      'turn_off_command': instance.turnOffCommand,
      'mqtt_msg_name': instance.mqttMessageName,
      'has_filter': instance.hasFilter,
    };
