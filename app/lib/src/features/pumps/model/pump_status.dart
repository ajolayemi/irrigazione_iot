// ignore_for_file: public_member_api_docs, sort_constructors_first
// A representation of the status of a pump.
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

part 'pump_status.g.dart';

@JsonSerializable()
class PumpStatus extends Equatable {
  const PumpStatus({
    required this.id,
    required this.pumpId,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String pumpId;
  // pump status are passed in as a string value because the status will be managed
  // using MQTT messages that sends and receives a string value
  // an internal logic will convert the string value to a boolean value when needed
  final String status;
  final DateTime createdAt;

  @override
  List<Object> get props => [id, pumpId, status, createdAt];

  factory PumpStatus.fromJson(Map<String, dynamic> json) =>
      _$PumpStatusFromJson(json);

  Map<String, dynamic> toJson() => _$PumpStatusToJson(this);
}

extension PumpStatusX on PumpStatus {
  bool translatePumpStatusToBoolean(Pump pump) => status == pump.turnOnCommand;
}
