// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_pressure_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collector_pressure.g.dart';

@JsonSerializable()
class CollectorPressure extends Equatable {
  const CollectorPressure({
    this.id,
    this.filterInPressure,
    this.filterOutPressure,
    this.collectorId,
    this.createdAt,
  }) : pressureDifference = (filterInPressure ?? 0) - (filterOutPressure ?? 0);

  const CollectorPressure.empty()
      : id = '',
        filterInPressure = 0,
        filterOutPressure = 0,
        createdAt = null,
        collectorId = '',
        pressureDifference = 0;

  @JsonKey(
    name: CollectorPressureDatabaseKeys.id,
    includeToJson: false,
  )
  @IntConverter()
  final String? id;

  @JsonKey(name: CollectorPressureDatabaseKeys.filterInPressure)
  final double? filterInPressure;

  @JsonKey(name: CollectorPressureDatabaseKeys.filterOutPressure)
  final double? filterOutPressure;

  @JsonKey(name: CollectorPressureDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: CollectorPressureDatabaseKeys.collectorId)
  @IntConverter()
  final String? collectorId;

  @JsonKey(name: CollectorPressureDatabaseKeys.pressureDifference)
  final double? pressureDifference;

  @override
  List<Object?> get props {
    return [
      id,
      filterInPressure,
      filterOutPressure,
      createdAt,
      collectorId,
      pressureDifference,
    ];
  }

  factory CollectorPressure.fromJson(Map<String, dynamic> json) =>
      _$CollectorPressureFromJson(json);

  Map<String, dynamic> toJson() => _$CollectorPressureToJson(this);

  factory CollectorPressure.fromEntity(LocalCollectorPressure? entity) {
    return CollectorPressure(
      id: entity?.id.toString() ?? '',
      filterInPressure: entity?.filterInPressure ?? 0,
      filterOutPressure: entity?.filterOutPressure ?? 0,
      createdAt: entity?.createdAt,
      collectorId: entity?.collectorId ?? '',
    );
  }

  LocalCollectorPressure toEntity() {
    return LocalCollectorPressure()
      ..id = int.tryParse(id ?? '')
      ..createdAt = createdAt
      ..filterInPressure = filterInPressure
      ..filterOutPressure = filterOutPressure
      ..collectorId = collectorId;
  }
}

extension CollectorPressureListExt on List<CollectorPressure> {
  List<LocalCollectorPressure> toEntities() {
    return map((e) => e.toEntity()).toList();
  }
}
