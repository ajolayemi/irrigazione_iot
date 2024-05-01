// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/model/sector_pump_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'sector_pump.g.dart';

@JsonSerializable()
class SectorPump extends Equatable {
  const SectorPump({
    required this.id,
    required this.sectorId,
    required this.pumpId,
    this.createdAt,
  });

  const SectorPump.empty()
      : id = '',
        sectorId = '',
        pumpId = '',
        createdAt = null;

  @JsonKey(name: SectorPumpDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: SectorPumpDatabaseKeys.sectorId)
  @IntConverter()
  final String sectorId;

  @JsonKey(name: SectorPumpDatabaseKeys.pumpId)
  @IntConverter()
  final String pumpId;

  @JsonKey(name: SectorPumpDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, sectorId, pumpId, createdAt];

  factory SectorPump.fromJson(Map<String, dynamic> json) =>
      _$SectorPumpFromJson(json);

  Map<String, dynamic> toJson() => _$SectorPumpToJson(this);

  SectorPump copyWith({
    String? id,
    String? sectorId,
    String? pumpId,
    DateTime? createdAt,
  }) {
    return SectorPump(
      id: id ?? this.id,
      sectorId: sectorId ?? this.sectorId,
      pumpId: pumpId ?? this.pumpId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
