// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_database_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sector.g.dart';

@JsonSerializable()
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
    required this.mqttMsgName,
    required this.hasFilter,
    this.createdAt,
    this.updatedAt,
  }) : totalConsumption = waterConsumptionPerHour * numOfPlants;

  const Sector.empty()
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
        createdAt = null,
        updatedAt = null,
        mqttMsgName = '',
        hasFilter = false;

  @JsonKey(name: SectorDatabaseKeys.id)
  final String id;
  @JsonKey(name: SectorDatabaseKeys.name)
  final String name;
  @JsonKey(name: SectorDatabaseKeys.area)
  final double area;
  @JsonKey(name: SectorDatabaseKeys.numOfPlants)
  final double numOfPlants;
  @JsonKey(name: SectorDatabaseKeys.waterConsumptionPerHour)
  final double waterConsumptionPerHour;
  @JsonKey(name: SectorDatabaseKeys.irrigationSystemType)
  final IrrigationSystem irrigationSystemType;
  @JsonKey(name: SectorDatabaseKeys.irrigationSource)
  final IrrigationSource irrigationSource;
  @JsonKey(name: SectorDatabaseKeys.turnOnCommand)
  final String turnOnCommand;
  @JsonKey(name: SectorDatabaseKeys.turnOffCommand)
  final String turnOffCommand;
  @JsonKey(name: SectorDatabaseKeys.notes)
  final String notes;
  @JsonKey(name: SectorDatabaseKeys.totalConsumption)
  final double totalConsumption;
  @JsonKey(name: SectorDatabaseKeys.specieId)
  final String specieId;
  @JsonKey(name: SectorDatabaseKeys.varietyId)
  final String varietyId;
  @JsonKey(name: SectorDatabaseKeys.companyId)
  final String companyId;
  @JsonKey(name: SectorDatabaseKeys.createdAt)
  final DateTime? createdAt;
  @JsonKey(name: SectorDatabaseKeys.updatedAt)
  final DateTime? updatedAt;
  @JsonKey(name: SectorDatabaseKeys.mqttMsgName)
  final String mqttMsgName;
  @JsonKey(name: SectorDatabaseKeys.hasFilter)
  final bool hasFilter;

  @override
  List<Object?> get props {
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

  factory Sector.fromJson(Map<String, dynamic> json) => _$SectorFromJson(json);

  Map<String, dynamic> toJson() => _$SectorToJson(this);
}

extension SectorX on Sector {
  String getMqttStatusCommand(bool status) =>
      status ? turnOnCommand : turnOffCommand;
}
