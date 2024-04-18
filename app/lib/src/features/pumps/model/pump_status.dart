import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump.dart';

part 'pump_status.g.dart';

@JsonSerializable()
class PumpStatus extends Equatable {
  const PumpStatus({
    required this.id,
    required this.pumpId,
    required this.status,
    this.createdAt,
  });

  @JsonKey(name: PumpStatusDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;
  @JsonKey(name: PumpStatusDatabaseKeys.pumpId)
  @IntConverter()
  final String pumpId;
  // pump status are passed in as a string value because the status will be managed
  // using MQTT messages that sends and receives a string value
  // an internal logic will convert the string value to a boolean value when needed
  @JsonKey(name: PumpStatusDatabaseKeys.status)
  final String status;
  @JsonKey(name: PumpStatusDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, pumpId, status, createdAt];

  factory PumpStatus.fromJson(Map<String, dynamic> json) =>
      _$PumpStatusFromJson(json);

  Map<String, dynamic> toJson() => _$PumpStatusToJson(this);
}

extension PumpStatusX on PumpStatus {
  bool translatePumpStatusToBoolean(Pump pump) => status == pump.turnOnCommand;
}
