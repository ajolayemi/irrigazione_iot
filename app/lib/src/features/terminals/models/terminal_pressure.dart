import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/terminals/models/terminal_pressure_database_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terminal_pressure.g.dart';

@JsonSerializable()
class TerminalPressure extends Equatable {
  const TerminalPressure({
    required this.id,
    required this.collectorId,
    required this.pressure,
    this.createdAt,
  });

  @JsonKey(name: TerminalPressureDatabaseKeys.id)
  final String id;
  @JsonKey(name: TerminalPressureDatabaseKeys.collectorId)
  final String collectorId;
  @JsonKey(name: TerminalPressureDatabaseKeys.pressure)
  final double pressure;
  @JsonKey(name: TerminalPressureDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, collectorId, pressure, createdAt];

  factory TerminalPressure.fromJson(Map<String, dynamic> json) =>
      _$TerminalPressureFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalPressureToJson(this);
}
