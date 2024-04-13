// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_supabase_keys.dart';

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
      PumpSupabaseKeys.id: id,
      PumpSupabaseKeys.name: name,
      PumpSupabaseKeys.capacityInVolume: capacityInVolume,
      PumpSupabaseKeys.consumeRateInKw: consumeRateInKw,
      PumpSupabaseKeys.companyId: companyId,
      PumpSupabaseKeys.createdAt: createdAt.toIso8601String(),
      PumpSupabaseKeys.updatedAt: updatedAt.toIso8601String(),
      PumpSupabaseKeys.turnOnCommand: turnOnCommand,
      PumpSupabaseKeys.turnOffCommand: turnOffCommand,
      PumpSupabaseKeys.mqttMessageName: mqttMessageName,
      PumpSupabaseKeys.hasFilter: hasFilter,
    };
  }

  static Pump fromJson(Map<String, dynamic> json) {
    return Pump(
      id: json[PumpSupabaseKeys.id] as String,
      name: json[PumpSupabaseKeys.name] as String,
      capacityInVolume: json[PumpSupabaseKeys.capacityInVolume] as double,
      consumeRateInKw: json[PumpSupabaseKeys.consumeRateInKw] as double,
      companyId: json[PumpSupabaseKeys.companyId] as String,
      createdAt: DateTime.parse(json[PumpSupabaseKeys.createdAt]),
      updatedAt: DateTime.parse(json[PumpSupabaseKeys.updatedAt]),
      turnOnCommand: json[PumpSupabaseKeys.turnOnCommand] as String,
      turnOffCommand: json[PumpSupabaseKeys.turnOffCommand] as String,
      mqttMessageName: json[PumpSupabaseKeys.mqttMessageName] as String,
      hasFilter: json[PumpSupabaseKeys.hasFilter] as bool,
    );
  }
}

extension PumpX on Pump {
  String getStatusCommand(bool status) {
    return status ? turnOnCommand : turnOffCommand;
  }
}
