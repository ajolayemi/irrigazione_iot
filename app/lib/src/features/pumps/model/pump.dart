// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_database_keys.dart';
import 'package:json_annotation/json_annotation.dart';

// TODO: add pump company
// TODO: prevalenza, portata,

part 'pump.g.dart';

@JsonSerializable()
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

  @JsonKey(name: PumpDatabaseKeys.id)
  final String id;
  @JsonKey(name: PumpDatabaseKeys.name)
  final String name;
  @JsonKey(name: PumpDatabaseKeys.capacityInVolume)
  final double capacityInVolume;
  @JsonKey(name: PumpDatabaseKeys.consumeRateInKw)
  final double consumeRateInKw;
  @JsonKey(name: PumpDatabaseKeys.companyId)
  final String companyId;
  @JsonKey(name: PumpDatabaseKeys.createdAt)
  final DateTime createdAt;
  @JsonKey(name: PumpDatabaseKeys.updatedAt)
  final DateTime updatedAt;
  @JsonKey(name: PumpDatabaseKeys.turnOnCommand)
  final String turnOnCommand;
  @JsonKey(name: PumpDatabaseKeys.turnOffCommand)
  final String turnOffCommand;
  @JsonKey(name: PumpDatabaseKeys.mqttMessageName)
  final String mqttMessageName;
  @JsonKey(name: PumpDatabaseKeys.hasFilter)
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

  factory Pump.fromJson(Map<String, dynamic> json) => _$PumpFromJson(json);

  Map<String, dynamic> toJson() => _$PumpToJson(this);
}

extension PumpX on Pump {
  String getStatusCommand(bool status) {
    return status ? turnOnCommand : turnOffCommand;
  }
}
