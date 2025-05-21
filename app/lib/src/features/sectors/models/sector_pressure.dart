import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'sector_pressure.g.dart';

@JsonSerializable()
class SectorPressure extends Equatable {
  const SectorPressure({
    this.id,
    this.sectorId,
    this.pressure,
    this.createdAt,
  });

  @JsonKey(name: SectorPressureDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String? id;
  @JsonKey(name: SectorPressureDatabaseKeys.sectorId)
  @IntConverter()
  final String? sectorId;
  @JsonKey(name: SectorPressureDatabaseKeys.pressure)
  final double? pressure;
  @JsonKey(name: SectorPressureDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, sectorId, pressure, createdAt];

  factory SectorPressure.fromJson(Map<String, dynamic> json) =>
      _$SectorPressureFromJson(json);

  Map<String, dynamic> toJson() => _$SectorPressureToJson(this);

  factory SectorPressure.fromEntity(MqttSectorPressure? entity) {
    return SectorPressure(
      id: entity?.id.toString() ?? '',
      sectorId: entity?.sectorId ?? '',
      pressure: entity?.pressure ?? 0.0,
      createdAt: entity?.createdAt,
    );
  }

  MqttSectorPressure toEntity() {
    return MqttSectorPressure()
      ..id = int.tryParse(id ?? '')
      ..sectorId = sectorId
      ..pressure = pressure
      ..createdAt = createdAt;
  }
}

extension SectorPressureListExt on List<SectorPressure> {
  List<MqttSectorPressure> toEntities() {
    return map((e) => e.toEntity()).toList();
  }
}
