// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/model/pump_pressure_database_keys.dart';

part 'pump_pressure.g.dart';

@JsonSerializable()
class PumpPressure extends Equatable {
  const PumpPressure({
    required this.id,
    required this.pumpId,
    required this.filterInPressure,
    required this.filterOutPressure,
  this.createdAt,
  }) : pressureDifference = filterInPressure - filterOutPressure;

  @JsonKey(name: PumpPressureDatabaseKeys.id)
  final String id;
  @JsonKey(name: PumpPressureDatabaseKeys.pumpId)
  final String pumpId;
  @JsonKey(name: PumpPressureDatabaseKeys.filterInPressure)
  final double filterInPressure;
  @JsonKey(name: PumpPressureDatabaseKeys.filterOutPressure)
  final double filterOutPressure;
  @JsonKey(name: PumpPressureDatabaseKeys.pressureDifference)
  final double pressureDifference;
  @JsonKey(name: PumpPressureDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props {
    return [
      id,
      pumpId,
      filterInPressure,
      filterOutPressure,
      pressureDifference,
      createdAt,
    ];
  }

  factory PumpPressure.fromJson(Map<String, dynamic> json) =>
      _$PumpPressureFromJson(json);

  Map<String, dynamic> toJson() => _$PumpPressureToJson(this);
}
