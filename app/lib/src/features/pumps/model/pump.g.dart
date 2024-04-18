// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pump _$PumpFromJson(Map<String, dynamic> json) => Pump(
      id: const IntConverter().fromJson(json['id'] as int),
      name: json['name'] as String,
      capacityInVolume: (json['capacity_in_volume'] as num).toDouble(),
      consumeRateInKw: (json['consume_rate_in_kw'] as num).toDouble(),
      turnOnCommand: json['turn_on_command'] as String,
      turnOffCommand: json['turn_off_command'] as String,
      mqttMessageName: json['mqtt_msg_name'] as String,
      hasFilter: json['has_filter'] as bool,
      companyId: const IntConverter().fromJson(json['company_id'] as int),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PumpToJson(Pump instance) => <String, dynamic>{
      'name': instance.name,
      'capacity_in_volume': instance.capacityInVolume,
      'consume_rate_in_kw': instance.consumeRateInKw,
      'company_id': const IntConverter().toJson(instance.companyId),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'turn_on_command': instance.turnOnCommand,
      'turn_off_command': instance.turnOffCommand,
      'mqtt_msg_name': instance.mqttMessageName,
      'has_filter': instance.hasFilter,
    };
