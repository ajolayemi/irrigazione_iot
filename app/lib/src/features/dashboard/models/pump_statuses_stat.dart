// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/dashboard/models/pump_statuses_stat_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'pump_statuses_stat.g.dart';

@JsonSerializable()

/// A model representation of pumps currently switched on.
class PumpStatusesStat extends Equatable {
  const PumpStatusesStat({
    required this.id,
    required this.totalDurationInSeconds,
    required this.statusBoolean,
    required this.pumpId,
    required this.companyId,
  });

  @JsonKey(name: 'id')
  @IntConverter()
  final String id;

  @JsonKey(name: PumpStatusesStatDatabaseKeys.totalDurationInSeconds)
  final int totalDurationInSeconds;

  @JsonKey(name: PumpStatusesStatDatabaseKeys.statusBoolean)
  final bool statusBoolean;

  @JsonKey(name: PumpStatusesStatDatabaseKeys.pumpId)
  @IntConverter()
  final String pumpId;

  @JsonKey(name: PumpStatusesStatDatabaseKeys.companyId)
  @IntConverter()
  final String companyId;

  @override
  List<Object> get props {
    return [
      id,
      totalDurationInSeconds,
      statusBoolean,
      pumpId,
      companyId,
    ];
  }

  factory PumpStatusesStat.fromJson(Map<String, dynamic> json) =>
      _$PumpStatusesStatFromJson(json);

  Map<String, dynamic> toJson() => _$PumpStatusesStatToJson(this);
}
