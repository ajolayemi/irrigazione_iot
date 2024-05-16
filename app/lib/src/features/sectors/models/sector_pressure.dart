import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/models/sector_pressure_database_keys.dart';

part 'sector_pressure.g.dart';

@JsonSerializable()
class SectorPressure extends Equatable {
  const SectorPressure({
    required this.id,
    required this.sectorId,
    required this.pressure,
    this.createdAt,
  });

  @JsonKey(name: SectorPressureDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;
  @JsonKey(name: SectorPressureDatabaseKeys.sectorId)
  @IntConverter()
  final String sectorId;
  @JsonKey(name: SectorPressureDatabaseKeys.pressure)
  final double pressure;
  @JsonKey(name: SectorPressureDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, sectorId, pressure, createdAt];

  factory SectorPressure.fromJson(Map<String, dynamic> json) =>
      _$SectorPressureFromJson(json);

  Map<String, dynamic> toJson() => _$SectorPressureToJson(this);
}
