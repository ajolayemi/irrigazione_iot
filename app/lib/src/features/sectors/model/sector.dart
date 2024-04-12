// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../config/enums/irrigation_enums.dart';
import '../../company_users/model/company.dart';

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
    required this.irrigationSystemType,
    required this.irrigationSource,
    required this.turnOnCommand,
    required this.turnOffCommand,
    this.notes,
  }) : totalWaterConsumption = numOfPlants * waterConsumptionPerHourByPlant;

  const Sector.empty()
      : id = '',
        companyId = '',
        name = '',
        availableSpecie = '',
        specieVariety = '',
        area = 0,
        numOfPlants = 0,
        waterConsumptionPerHourByPlant = 0,
        totalWaterConsumption = 0,
        irrigationSystemType = IrrigationSystemType.drip,
        irrigationSource = IrrigationSource.well,
        turnOnCommand = '',
        turnOffCommand = '',
        notes = null;

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

  // * the mqtt command to turn on this sector
  final String turnOnCommand;

  // * the mqtt command to turn off this sector
  final String turnOffCommand;

  // * extra notes
  final String? notes;

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
      turnOnCommand,
      turnOffCommand,
      notes,
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
    IrrigationSystemType? irrigationSystemType,
    IrrigationSource? irrigationSource,
    String? turnOnCommand,
    String? turnOffCommand,
    String? notes,
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
      irrigationSystemType: irrigationSystemType ?? this.irrigationSystemType,
      irrigationSource: irrigationSource ?? this.irrigationSource,
      turnOnCommand: turnOnCommand ?? this.turnOnCommand,
      turnOffCommand: turnOffCommand ?? this.turnOffCommand,
      notes: notes ?? this.notes,
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
      'turnOnCommand': turnOnCommand,
      'turnOffCommand': turnOffCommand,
      'notes': notes,
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
      irrigationSystemType:
          map['irrigationSystemType'].toString().toIrrigationSystemType(),
      irrigationSource: map['irrigationSource'].toString().toIrrigationSource(),
      turnOnCommand: map['turnOnCommand'] as String,
      turnOffCommand: map['turnOffCommand'] as String,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  @override
  String toString() {
    return '''Sector(id: $id, companyId: $companyId, name: $name
    availableSpecie: $availableSpecie, specieVariety: $specieVariety, area: $area,
    numOfPlants: $numOfPlants, waterConsumptionPerHourByPlant: $waterConsumptionPerHourByPlant, 
    totalWaterConsumption: $totalWaterConsumption, irrigationSystemType: $irrigationSystemType, 
    irrigationSource: $irrigationSource,turnOnCommand: $turnOnCommand, 
    turnOffCommand: $turnOffCommand, notes: $notes)''';
  }
}

extension SectorX on Sector {
  String get displayName => '$availableSpecie $specieVariety';
  String getMqttStatusCommand(bool status) =>
      status ? turnOnCommand : turnOffCommand;
}
