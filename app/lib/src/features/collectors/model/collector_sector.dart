import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector_sector_database_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collector_sector.g.dart';

@JsonSerializable()
class CollectorSector extends Equatable {
  const CollectorSector({
    required this.id,
    required this.collectorId,
    required this.sectorId,
    required this.createdAt,
  });

  CollectorSector.empty()
      : id = '',
        collectorId = '',
        sectorId = '',
        createdAt = DateTime.parse('2024-01-01');
  @JsonKey(name: CollectorSectorDatabaseKeys.id)
  final String id;
  @JsonKey(name: CollectorSectorDatabaseKeys.collectorId)
  final String collectorId;
  @JsonKey(name: CollectorSectorDatabaseKeys.sectorId)
  final String sectorId;
  @JsonKey(name: CollectorSectorDatabaseKeys.createdAt)
  final DateTime createdAt;

  @override
  List<Object> get props => [id, collectorId, sectorId, createdAt];

  factory CollectorSector.fromJson(Map<String, dynamic> json) =>
      _$CollectorSectorFromJson(json);

  Map<String, dynamic> toJson() => _$CollectorSectorToJson(this);
}
