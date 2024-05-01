// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/pumps/model/pump_flow_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'pump_flow.g.dart';

@JsonSerializable()
class PumpFlow extends Equatable {
  const PumpFlow({
    required this.id,
    required this.pumpId,
    required this.flow,
   this.createdAt,
  });

  @JsonKey(name: PumpFlowDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;
  @JsonKey(name: PumpFlowDatabaseKeys.pumpId)
  @IntConverter()
  final String pumpId;
  @JsonKey(name: PumpFlowDatabaseKeys.flow)
  final double flow;
  @JsonKey(name: PumpFlowDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, pumpId, flow, createdAt];

  factory PumpFlow.fromJson(Map<String, dynamic> json) =>
      _$PumpFlowFromJson(json);

  Map<String, dynamic> toJson() => _$PumpFlowToJson(this);
}
