import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/model/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/model/sector_status_database_keys.dart';

part 'sector_status.g.dart';

@JsonSerializable()
class SectorStatus extends Equatable {
  const SectorStatus({
    required this.id,
    required this.sectorId,
    required this.status,
    this.createdAt,
  });

  @JsonKey(name: SectorStatusDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;
  @JsonKey(name: SectorStatusDatabaseKeys.sectorId)
  @IntConverter()
  final String sectorId;
  @JsonKey(name: SectorStatusDatabaseKeys.status)
  final String status;
  @JsonKey(name: SectorStatusDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, sectorId, status, createdAt];

  factory SectorStatus.fromJson(Map<String, dynamic> json) =>
      _$SectorStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SectorStatusToJson(this);
}

extension SectorStatusX on SectorStatus {
  bool translateSectorStatusToBoolean(Sector sector) {
    return status == sector.turnOnCommand;
  }
}
