// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_supabase_keys.dart';

class Sector extends Equatable {
  const Sector({
    required this.id,
    required this.name,
    required this.area,
    required this.numOfPlants,
    required this.waterConsumptionPerHour,
    required this.irrigationSystemType,
    required this.irrigationSource,
    required this.turnOnCommand,
    required this.turnOffCommand,
    required this.notes,
    required this.specieId,
    required this.varietyId,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.mqttMsgName,
    required this.hasFilter,
  }) : totalConsumption = waterConsumptionPerHour * numOfPlants;

  Sector.empty()
      : id = '',
        name = '',
        area = 0,
        numOfPlants = 0,
        waterConsumptionPerHour = 0,
        irrigationSystemType = IrrigationSystem.other,
        irrigationSource = IrrigationSource.other,
        turnOnCommand = '',
        turnOffCommand = '',
        notes = '',
        totalConsumption = 0,
        specieId = '',
        varietyId = '',
        companyId = '',
        createdAt = DateTime.parse('2024-01-01'),
        updatedAt = DateTime.parse('2024-01-01'),
        mqttMsgName = '',
        hasFilter = false;

  final String id;
  final String name;
  final double area;
  final double numOfPlants;
  final double waterConsumptionPerHour;
  final IrrigationSystem irrigationSystemType;
  final IrrigationSource irrigationSource;
  final String turnOnCommand;
  final String turnOffCommand;
  final String notes;
  final double totalConsumption;
  final String specieId;
  final String varietyId;
  final String companyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String mqttMsgName;
  final bool hasFilter;

  @override
  List<Object> get props {
    return [
      id,
      name,
      area,
      numOfPlants,
      waterConsumptionPerHour,
      irrigationSystemType,
      irrigationSource,
      turnOnCommand,
      turnOffCommand,
      notes,
      totalConsumption,
      specieId,
      varietyId,
      companyId,
      createdAt,
      updatedAt,
      mqttMsgName,
      hasFilter,
    ];
  }

  Sector copyWith({
    String? id,
    String? name,
    double? area,
    double? numOfPlants,
    double? waterConsumptionPerHour,
    IrrigationSystem? irrigationSystemType,
    IrrigationSource? irrigationSource,
    String? turnOnCommand,
    String? turnOffCommand,
    String? notes,
    String? specieId,
    String? varietyId,
    String? companyId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? mqttMsgName,
    bool? hasFilter,
  }) {
    return Sector(
      id: id ?? this.id,
      name: name ?? this.name,
      area: area ?? this.area,
      numOfPlants: numOfPlants ?? this.numOfPlants,
      waterConsumptionPerHour:
          waterConsumptionPerHour ?? this.waterConsumptionPerHour,
      irrigationSystemType: irrigationSystemType ?? this.irrigationSystemType,
      irrigationSource: irrigationSource ?? this.irrigationSource,
      turnOnCommand: turnOnCommand ?? this.turnOnCommand,
      turnOffCommand: turnOffCommand ?? this.turnOffCommand,
      notes: notes ?? this.notes,
      specieId: specieId ?? this.specieId,
      varietyId: varietyId ?? this.varietyId,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mqttMsgName: mqttMsgName ?? this.mqttMsgName,
      hasFilter: hasFilter ?? this.hasFilter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      SectorSupabaseKeys.id: id,
      SectorSupabaseKeys.name: name,
      SectorSupabaseKeys.area: area,
      SectorSupabaseKeys.numOfPlants: numOfPlants,
      SectorSupabaseKeys.waterConsumptionPerHour: waterConsumptionPerHour,
      SectorSupabaseKeys.irrigationSystemType: irrigationSystemType.name,
      SectorSupabaseKeys.irrigationSource: irrigationSource.name,
      SectorSupabaseKeys.turnOnCommand: turnOnCommand,
      SectorSupabaseKeys.turnOffCommand: turnOffCommand,
      SectorSupabaseKeys.notes: notes,
      SectorSupabaseKeys.specieId: specieId,
      SectorSupabaseKeys.varietyId: varietyId,
      SectorSupabaseKeys.companyId: companyId,
      SectorSupabaseKeys.createdAt: createdAt.toIso8601String(),
      SectorSupabaseKeys.updatedAt: updatedAt.toIso8601String(),
      SectorSupabaseKeys.mqttMsgName: mqttMsgName,
      SectorSupabaseKeys.hasFilter: hasFilter,
    };
  }

  static Sector fromJson(Map<String, dynamic> json) {
    return Sector(
      id: json[SectorSupabaseKeys.id],
      name: json[SectorSupabaseKeys.name],
      area: json[SectorSupabaseKeys.area],
      numOfPlants: json[SectorSupabaseKeys.numOfPlants],
      waterConsumptionPerHour: json[SectorSupabaseKeys.waterConsumptionPerHour],
      irrigationSystemType:
          (json[SectorSupabaseKeys.irrigationSystemType] as String)
              .toIrrigationSystemType(),
      irrigationSource: (json[SectorSupabaseKeys.irrigationSource] as String)
          .toIrrigationSource(),
      turnOnCommand: json[SectorSupabaseKeys.turnOnCommand],
      turnOffCommand: json[SectorSupabaseKeys.turnOffCommand],
      notes: json[SectorSupabaseKeys.notes],
      specieId: json[SectorSupabaseKeys.specieId],
      varietyId: json[SectorSupabaseKeys.varietyId],
      companyId: json[SectorSupabaseKeys.companyId],
      createdAt: DateTime.parse(json[SectorSupabaseKeys.createdAt]),
      updatedAt: DateTime.parse(json[SectorSupabaseKeys.updatedAt]),
      mqttMsgName: json[SectorSupabaseKeys.mqttMsgName],
      hasFilter: json[SectorSupabaseKeys.hasFilter],
    );
  }
}

extension SectorX on Sector {
  String getMqttStatusCommand(bool status) =>
      status ? turnOnCommand : turnOffCommand;
}
