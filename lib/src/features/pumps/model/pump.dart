// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/features/company_users/model/company.dart';

typedef PumpID = String;

class Pump extends Equatable {
  const Pump({
    required this.id,
    required this.name,
    required this.capacityInVolume,
    required this.consumeRateInKw,
    required this.commandForOn,
    required this.commandForOff,
    required this.companyId,
  });

  const Pump.empty()
      : id = '',
        name = '',
        capacityInVolume = 0,
        consumeRateInKw = 0,
        commandForOn = '',
        commandForOff = '',
        companyId = '';

  /// A unique identifier for the pump
  final PumpID id;

  /// The name of the pump
  final String name;

  /// The capacity of the pump in volume
  final double capacityInVolume;

  /// The consume rate of the pump in kilowatts
  final double consumeRateInKw;

  /// The command to turn on the pump, i.e the one sent to and from MQTT
  final String commandForOn;

  /// The command to turn off the pump, i.e the one sent to and from MQTT
  final String commandForOff;

  /// An id to identify the company the pump belongs to
  final CompanyID companyId;

  @override
  List<Object> get props {
    return [
      id,
      name,
      capacityInVolume,
      consumeRateInKw,
      commandForOn,
      commandForOff,
      companyId,
    ];
  }

  Pump copyWith({
    PumpID? id,
    String? name,
    double? capacityInVolume,
    double? consumeRateInKw,
    String? commandForOn,
    String? commandForOff,
    CompanyID? companyId,
  }) {
    return Pump(
      id: id ?? this.id,
      name: name ?? this.name,
      capacityInVolume: capacityInVolume ?? this.capacityInVolume,
      consumeRateInKw: consumeRateInKw ?? this.consumeRateInKw,
      commandForOn: commandForOn ?? this.commandForOn,
      commandForOff: commandForOff ?? this.commandForOff,
      companyId: companyId ?? this.companyId,
    );
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'capacityInVolume': capacityInVolume,
      'consumeRateInKw': consumeRateInKw,
      'commandForOn': commandForOn,
      'commandForOff': commandForOff,
      'companyId': companyId
    };
  }

  factory Pump.fromMap(Map<String, dynamic> map) {
    return Pump(
      id: map['id'] as PumpID,
      name: map['name'] as String,
      capacityInVolume: map['capacityInVolume'] as double,
      consumeRateInKw: map['consumeRateInKw'] as double,
      commandForOn: map['commandForOn'] as String,
      commandForOff: map['commandForOff'] as String,
      companyId: map['companyId'] as CompanyID,
    );
  }
}

extension PumpX on Pump {
  String getStatusCommand(bool status) {
    return status ? commandForOn : commandForOff;
  }
}
