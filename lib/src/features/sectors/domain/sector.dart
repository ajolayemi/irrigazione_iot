// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/config/enums/irrigation_enums.dart';
import 'package:irrigazione_iot/src/features/pumps/domain/pump.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';

typedef SectorID = String;

class Sector extends Equatable {
  const Sector({
    required this.id,
    required this.companyId,
    required this.name,
    required this.availableSpecie,
    required this.specieVariety,
    required this.area,
    required this.numOfPlants,
    required this.waterConsumptionPerHourByPlant,
    required this.totalWaterConsumption,
    required this.irrigationSystemType,
    required this.irrigationSource,
    required this.solenoidValveName,
    required this.turnOnCommand,
    required this.turnOffCommand,
    this.pumpId,
    this.notes,
  });

  // * the id of the sector
  final SectorID id;

  // * an id that identifies the company that owns this sector
  final CompanyID companyId;

  // * the name of the sector
  final String name;

  // * a generic specie like arancia, limone for the
  final String availableSpecie;

  // * the variety of the specie like sanguinello, tarocco
  final String specieVariety;

  // * the area occupied bt this sector
  final double area;

  // * the number of plants in this sector
  final int numOfPlants;

  // * the amount of water consumed per hour by each plant in this sector
  final double waterConsumptionPerHourByPlant;

  // *  the total amount of water consumed
  // * this value should be calculated by the backend
  // * it's the result of the multiplication of the waterConsumptionPerHourByPlant by the numOfPlants
  final double totalWaterConsumption;

  // * irrigation system type
  final IrrigationSystemType irrigationSystemType;

  // * irrigation source
  final IrrigationSource irrigationSource;

  // * solenoid valve name (elettrovalvola)
  final String solenoidValveName;

  // * the mqtt command to turn on this sector
  final String turnOnCommand;

  // * the mqtt command to turn off this sector
  final String turnOffCommand;

  // * extra notes
  final String? notes;

  // * the id of the pump that irrigates this sector
  final PumpID? pumpId;

  @override
  List<Object?> get props {
    return [
      id,
      companyId,
      name,
      availableSpecie,
      specieVariety,
      area,
      numOfPlants,
      waterConsumptionPerHourByPlant,
      totalWaterConsumption,
      irrigationSystemType,
      irrigationSource,
      solenoidValveName,
      turnOnCommand,
      turnOffCommand,
      notes,
      pumpId,
    ];
  }

  Sector copyWith({
    SectorID? id,
    CompanyID? companyId,
    String? name,
    String? availableSpecie,
    String? specieVariety,
    double? area,
    int? numOfPlants,
    double? waterConsumptionPerHourByPlant,
    double? totalWaterConsumption,
    IrrigationSystemType? irrigationSystemType,
    IrrigationSource? irrigationSource,
    String? solenoidValveName,
    String? turnOnCommand,
    String? turnOffCommand,
    String? notes,
    PumpID? pumpId,
  }) {
    return Sector(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      availableSpecie: availableSpecie ?? this.availableSpecie,
      specieVariety: specieVariety ?? this.specieVariety,
      area: area ?? this.area,
      numOfPlants: numOfPlants ?? this.numOfPlants,
      waterConsumptionPerHourByPlant:
          waterConsumptionPerHourByPlant ?? this.waterConsumptionPerHourByPlant,
      totalWaterConsumption:
          totalWaterConsumption ?? this.totalWaterConsumption,
      irrigationSystemType: irrigationSystemType ?? this.irrigationSystemType,
      irrigationSource: irrigationSource ?? this.irrigationSource,
      solenoidValveName: solenoidValveName ?? this.solenoidValveName,
      turnOnCommand: turnOnCommand ?? this.turnOnCommand,
      turnOffCommand: turnOffCommand ?? this.turnOffCommand,
      notes: notes ?? this.notes,
      pumpId: pumpId ?? this.pumpId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyId': companyId,
      'name': name,
      'availableSpecie': availableSpecie,
      'specieVariety': specieVariety,
      'area': area,
      'numOfPlants': numOfPlants,
      'waterConsumptionPerHourByPlant': waterConsumptionPerHourByPlant,
      'totalWaterConsumption': totalWaterConsumption,
      'irrigationSystemType': irrigationSystemType.uiName,
      'irrigationSource': irrigationSource.uiName,
      'solenoidValveName': solenoidValveName,
      'turnOnCommand': turnOnCommand,
      'turnOffCommand': turnOffCommand,
      'notes': notes,
      'pumpId': pumpId,
    };
  }

  factory Sector.fromMap(Map<String, dynamic> map) {
    return Sector(
      id: map['id'] as SectorID,
      companyId: map['companyId'] as CompanyID,
      name: map['name'] as String,
      availableSpecie: map['availableSpecie'] as String,
      specieVariety: map['specieVariety'] as String,
      area: map['area'] as double,
      numOfPlants: map['numOfPlants'] as int,
      waterConsumptionPerHourByPlant:
          map['waterConsumptionPerHourByPlant'] as double,
      totalWaterConsumption: map['totalWaterConsumption'] as double,
      irrigationSystemType:
          map['irrigationSystemType'].toString().toIrrigationSystemType(),
      irrigationSource: map['irrigationSource'].toString().toIrrigationSource(),
      solenoidValveName: map['solenoidValveName'] as String,
      turnOnCommand: map['turnOnCommand'] as String,
      turnOffCommand: map['turnOffCommand'] as String,
      notes: map['notes'] != null ? map['notes'] as String : null,
      pumpId: map['pumpId'] != null ? map['pumpId'] as PumpID : null,
    );
  }

  @override
  String toString() {
    return '''Sector(id: $id, companyId: $companyId, name: $name
    availableSpecie: $availableSpecie, specieVariety: $specieVariety, area: $area,
    numOfPlants: $numOfPlants, waterConsumptionPerHourByPlant: $waterConsumptionPerHourByPlant, 
    totalWaterConsumption: $totalWaterConsumption, irrigationSystemType: $irrigationSystemType, 
    irrigationSource: $irrigationSource, solenoidValveName: $solenoidValveName, 
    turnOnCommand: $turnOnCommand, turnOffCommand: $turnOffCommand, notes: $notes, pumpId: $pumpId)''';
  }
}

extension SectorX on Sector {
  String get displayName => '$availableSpecie $specieVariety';
  String getMqttStatusCommand(bool status) =>
      status ? turnOnCommand : turnOffCommand;
}
