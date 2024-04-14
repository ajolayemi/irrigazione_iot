// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_pressure_database_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collector_pressure.g.dart';

@JsonSerializable()
class CollectorPressure extends Equatable {
  const CollectorPressure({
    required this.id,
    required this.filterInPressure,
    required this.filterOutPressure,
    required this.createdAt,
    required this.collectorId,
  }) : pressureDifference = filterInPressure - filterOutPressure;

  CollectorPressure.empty()
      : id = '',
        filterInPressure = 0,
        filterOutPressure = 0,
        createdAt = DateTime.parse('2024-01-01'),
        collectorId = '',
        pressureDifference = 0;

  @JsonKey(name: CollectorPressureDatabaseKeys.id)
  final String id;
  @JsonKey(name: CollectorPressureDatabaseKeys.filterInPressure)
  final double filterInPressure;
  @JsonKey(name: CollectorPressureDatabaseKeys.filterOutPressure)
  final double filterOutPressure;
  @JsonKey(name: CollectorPressureDatabaseKeys.createdAt)
  final DateTime createdAt;
  @JsonKey(name: CollectorPressureDatabaseKeys.collectorId)
  final String collectorId;
  @JsonKey(name: CollectorPressureDatabaseKeys.pressureDifference)
  final double pressureDifference;

  @override
  List<Object> get props {
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
}
