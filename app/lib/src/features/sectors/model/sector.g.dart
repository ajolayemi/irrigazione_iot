// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sector _$SectorFromJson(Map<String, dynamic> json) => Sector(
      id: const IntConverter().fromJson(json['id'] as int),
      name: json['name'] as String,
      area: (json['area'] as num).toDouble(),
      numOfPlants: (json['num_of_plants'] as num).toDouble(),
      waterConsumptionPerHour:
          (json['water_consumption_per_hour'] as num).toDouble(),
      irrigationSystemType: $enumDecode(
          _$IrrigationSystemEnumMap, json['irrigation_system_type']),
      irrigationSource:
          $enumDecode(_$IrrigationSourceEnumMap, json['irrigation_source']),
      turnOnCommand: json['turn_on_command'] as String,
      turnOffCommand: json['turn_off_command'] as String,
      notes: json['notes'] as String,
      specieId: const IntConverter().fromJson(json['specie_id'] as int),
      varietyId: const IntConverter().fromJson(json['variety_id'] as int),
      companyId: const IntConverter().fromJson(json['company_id'] as int),
      mqttMsgName: json['mqtt_msg_name'] as String,
      hasFilter: json['has_filter'] as bool,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SectorToJson(Sector instance) => <String, dynamic>{
      'name': instance.name,
      'area': instance.area,
      'num_of_plants': instance.numOfPlants,
      'water_consumption_per_hour': instance.waterConsumptionPerHour,
      'irrigation_system_type':
          _$IrrigationSystemEnumMap[instance.irrigationSystemType]!,
      'irrigation_source':
          _$IrrigationSourceEnumMap[instance.irrigationSource]!,
      'turn_on_command': instance.turnOnCommand,
      'turn_off_command': instance.turnOffCommand,
      'notes': instance.notes,
      'specie_id': const IntConverter().toJson(instance.specieId),
      'variety_id': const IntConverter().toJson(instance.varietyId),
      'company_id': const IntConverter().toJson(instance.companyId),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'mqtt_msg_name': instance.mqttMsgName,
      'has_filter': instance.hasFilter,
    };

const _$IrrigationSystemEnumMap = {
  IrrigationSystem.pivot: 'pivot',
  IrrigationSystem.drip: 'drip',
  IrrigationSystem.rotolo: 'rotolo',
  IrrigationSystem.subirrigazione: 'subirrigazione',
  IrrigationSystem.sprinkler: 'sprinkler',
  IrrigationSystem.other: 'other',
};

const _$IrrigationSourceEnumMap = {
  IrrigationSource.well: 'well',
  IrrigationSource.cistern: 'cistern',
  IrrigationSource.river: 'river',
  IrrigationSource.lake: 'lake',
  IrrigationSource.canal: 'canal',
  IrrigationSource.invaso: 'invaso',
  IrrigationSource.consortium: 'consortium',
  IrrigationSource.other: 'other',
};
