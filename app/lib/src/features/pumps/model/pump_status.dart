import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/pumps/model/pump_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pump_status.g.dart';

@JsonSerializable()
class PumpStatus extends Equatable {
  const PumpStatus({
    required this.id,
    required this.pumpId,
    required this.status,
    required this.statusBoolean,
    this.createdAt,
  });

  @JsonKey(name: PumpStatusDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: PumpStatusDatabaseKeys.pumpId)
  @IntConverter()
  final String pumpId;

  @JsonKey(name: PumpStatusDatabaseKeys.status)
  final String status;

  @JsonKey(name: PumpStatusDatabaseKeys.statusBoolean)
  final bool statusBoolean;

  @JsonKey(name: PumpStatusDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, pumpId, status, createdAt];

  factory PumpStatus.fromJson(Map<String, dynamic> json) =>
      _$PumpStatusFromJson(json);

  Map<String, dynamic> toJson() => _$PumpStatusToJson(this);
}
