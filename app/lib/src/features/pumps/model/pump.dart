// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_database_keys.dart';

// TODO: add pump company
// TODO: prevalenza, portata,
class Pump extends Equatable {
  const Pump({
    required this.id,
    required this.name,
    required this.capacityInVolume,
    required this.consumeRateInKw,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.turnOnCommand,
    required this.turnOffCommand,
    required this.mqttMessageName,
    required this.hasFilter,
  });

  Pump.empty()
      : id = '',
        name = '',
        capacityInVolume = 0,
        consumeRateInKw = 0,
        companyId = '',
        createdAt = DateTime(2024),
        updatedAt = DateTime(2024),
        turnOnCommand = '',
        turnOffCommand = '',
        mqttMessageName = '',
        hasFilter = false;

  final String id;
  final String name;
  final double capacityInVolume;
  final double consumeRateInKw;
  final String companyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String turnOnCommand;
  final String turnOffCommand;
  final String mqttMessageName;
  final bool hasFilter;

  @override
  List<Object> get props {
    return [
      id,
      name,
      capacityInVolume,
      consumeRateInKw,
      companyId,
      createdAt,
      updatedAt,
      turnOnCommand,
      turnOffCommand,
      mqttMessageName,
      hasFilter,
    ];
  }

  Pump copyWith({
    String? id,
    String? name,
    double? capacityInVolume,
    double? consumeRateInKw,
    String? companyId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? turnOnCommand,
    String? turnOffCommand,
    String? mqttMessageName,
    bool? hasFilter,
  }) {
    return Pump(
      id: id ?? this.id,
      name: name ?? this.name,
      capacityInVolume: capacityInVolume ?? this.capacityInVolume,
      consumeRateInKw: consumeRateInKw ?? this.consumeRateInKw,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      turnOnCommand: turnOnCommand ?? this.turnOnCommand,
      turnOffCommand: turnOffCommand ?? this.turnOffCommand,
      mqttMessageName: mqttMessageName ?? this.mqttMessageName,
      hasFilter: hasFilter ?? this.hasFilter,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      PumpDatabaseKeys.id: id,
      PumpDatabaseKeys.name: name,
      PumpDatabaseKeys.capacityInVolume: capacityInVolume,
      PumpDatabaseKeys.consumeRateInKw: consumeRateInKw,
      PumpDatabaseKeys.companyId: companyId,
      PumpDatabaseKeys.createdAt: createdAt.toIso8601String(),
      PumpDatabaseKeys.updatedAt: updatedAt.toIso8601String(),
      PumpDatabaseKeys.turnOnCommand: turnOnCommand,
      PumpDatabaseKeys.turnOffCommand: turnOffCommand,
      PumpDatabaseKeys.mqttMessageName: mqttMessageName,
      PumpDatabaseKeys.hasFilter: hasFilter,
    };
  }

  static Pump fromJson(Map<String, dynamic> json) {
    return Pump(
      id: json[PumpDatabaseKeys.id] as String,
      name: json[PumpDatabaseKeys.name] as String,
      capacityInVolume: json[PumpDatabaseKeys.capacityInVolume] as double,
      consumeRateInKw: json[PumpDatabaseKeys.consumeRateInKw] as double,
      companyId: json[PumpDatabaseKeys.companyId] as String,
      createdAt: DateTime.parse(json[PumpDatabaseKeys.createdAt]),
      updatedAt: DateTime.parse(json[PumpDatabaseKeys.updatedAt]),
      turnOnCommand: json[PumpDatabaseKeys.turnOnCommand] as String,
      turnOffCommand: json[PumpDatabaseKeys.turnOffCommand] as String,
      mqttMessageName: json[PumpDatabaseKeys.mqttMessageName] as String,
      hasFilter: json[PumpDatabaseKeys.hasFilter] as bool,
    );
  }
}

extension PumpX on Pump {
  String getStatusCommand(bool status) {
    return status ? turnOnCommand : turnOffCommand;
  }
}
