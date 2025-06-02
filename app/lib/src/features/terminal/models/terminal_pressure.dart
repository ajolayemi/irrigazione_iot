import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/terminal/models/terminal_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'terminal_pressure.g.dart';

@JsonSerializable()
class TerminalPressure extends Equatable {
  const TerminalPressure({
    this.id,
    this.collectorId,
    this.pressure,
    this.createdAt,
  });

  @JsonKey(name: TerminalPressureDatabaseKeys.id)
  @IntConverter()
  final String? id;

  @JsonKey(name: TerminalPressureDatabaseKeys.collectorId)
  @IntConverter()
  final String? collectorId;

  @JsonKey(name: TerminalPressureDatabaseKeys.pressure)
  final double? pressure;

  @JsonKey(name: TerminalPressureDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, collectorId, pressure, createdAt];

  factory TerminalPressure.fromJson(Map<String, dynamic> json) =>
      _$TerminalPressureFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalPressureToJson(this);

  factory TerminalPressure.fromEntity(LocalTerminalPressure? entity) {
    return TerminalPressure(
      id: entity?.id.toString() ?? '',
      collectorId: entity?.collectorId ?? '',
      pressure: entity?.pressure ?? 0,
      createdAt: entity?.createdAt,
    );
  }
  LocalTerminalPressure toEntity() {
    return LocalTerminalPressure()
      ..id = int.tryParse(id ?? '')
      ..collectorId = collectorId
      ..pressure = pressure
      ..createdAt = createdAt;
  }
}

extension TerminalPressureListExt on List<TerminalPressure> {
  List<LocalTerminalPressure> toEntities() {
    return map((e) => e.toEntity()).toList();
  }
}
