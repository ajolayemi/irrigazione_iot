// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/collectors/model/collector_sector_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'collector_sector.g.dart';

@JsonSerializable()
class CollectorSector extends Equatable {
  const CollectorSector({
    required this.id,
    required this.collectorId,
    required this.sectorId,
    this.createdAt,
  });

  const CollectorSector.empty()
      : id = '',
        collectorId = '',
        sectorId = '',
        createdAt = null;

  @JsonKey(name: CollectorSectorDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: CollectorSectorDatabaseKeys.collectorId)
  @IntConverter()
  final String collectorId;

  @JsonKey(name: CollectorSectorDatabaseKeys.sectorId)
  @IntConverter()
  final String sectorId;

  @JsonKey(name: CollectorSectorDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, collectorId, sectorId, createdAt];

  factory CollectorSector.fromJson(Map<String, dynamic> json) =>
      _$CollectorSectorFromJson(json);

  Map<String, dynamic> toJson() => _$CollectorSectorToJson(this);

  CollectorSector copyWith({
    String? id,
    String? collectorId,
    String? sectorId,
    DateTime? createdAt,
  }) {
    return CollectorSector(
      id: id ?? this.id,
      collectorId: collectorId ?? this.collectorId,
      sectorId: sectorId ?? this.sectorId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
