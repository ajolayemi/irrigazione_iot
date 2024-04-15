// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/model/sector_pump_database_keys.dart';

part 'sector_pump.g.dart';

@JsonSerializable()
class SectorPump extends Equatable {
  const SectorPump({
    required this.id,
    required this.sectorId,
    required this.pumpId,
    this.createdAt,
  });

  @JsonKey(name: SectorPumpDatabaseKeys.id)
  final String id;
  @JsonKey(name: SectorPumpDatabaseKeys.sectorId)
  final String sectorId;
  @JsonKey(name: SectorPumpDatabaseKeys.pumpId)
  final String pumpId;
  @JsonKey(name: SectorPumpDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, sectorId, pumpId, createdAt];

  factory SectorPump.fromJson(Map<String, dynamic> json) =>
      _$SectorPumpFromJson(json);

  Map<String, dynamic> toJson() => _$SectorPumpToJson(this);
}
