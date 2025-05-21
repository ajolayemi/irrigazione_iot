import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/sectors/models/sector_status_database_keys.dart';

part 'sector_status.g.dart';

@JsonSerializable()
class SectorStatus extends Equatable {
  const SectorStatus({
     this.id,
     this.sectorId,
     this.status,
     this.statusBoolean,
     this.companyId,
    this.createdAt,
  });

  @JsonKey(name: SectorStatusDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String? id;

  @JsonKey(name: SectorStatusDatabaseKeys.sectorId)
  @IntConverter()
  final String? sectorId;

  @JsonKey(name: SectorStatusDatabaseKeys.status)
  final String? status;

  @JsonKey(name: SectorStatusDatabaseKeys.statusBoolean)
  final bool? statusBoolean;

  @JsonKey(name: SectorStatusDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @JsonKey(name: SectorStatusDatabaseKeys.companyId)
  final String? companyId;

  @override
  List<Object?> get props => [id, sectorId, status, createdAt];

  factory SectorStatus.fromJson(Map<String, dynamic> json) =>
      _$SectorStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SectorStatusToJson(this);

  factory SectorStatus.fromEntity(MqttSectorStatus? entity) {
    return SectorStatus(
      id: entity?.id.toString() ?? '',
      sectorId: entity?.status?.itemId ?? '',
      status: entity?.status?.status ?? '',
      statusBoolean: entity?.status?.statusBoolean ?? false,
      createdAt: entity?.status?.createdAt,
      companyId: entity?.status?.companyId ?? '',
    );
  }

  MqttSectorStatus toEntity() {
    final mqttStatus = MqttStatus()
      ..itemId = sectorId
      ..status = status
      ..statusBoolean = statusBoolean
      ..companyId = companyId
      ..createdAt = createdAt;

    return MqttSectorStatus()
      ..status = mqttStatus
      ..id = int.tryParse(id ?? '');
  }
}

extension SectorStatusesExt on List<SectorStatus> {
  List<MqttSectorStatus> toMqttStatuses() {
    return map((e) => e.toEntity()).toList();
  }

  List<SectorSwitchedOn> toSectorsSwitchedOn() {
    return map((e) => SectorSwitchedOn.fromSectorStatus(e)).toList();
  }
}
