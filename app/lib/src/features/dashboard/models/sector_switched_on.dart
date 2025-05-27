import 'package:irrigazione_iot/src/data/datasource/entities/mqtt_entities.dart';
import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on_database_keys.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sector_switched_on.g.dart';

@JsonSerializable()
class SectorSwitchedOn {
  SectorSwitchedOn({
    required this.id,
    required this.sectorId,
    required this.statusBoolean,
  });

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.id)
  @IntConverter()
  final String id;

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.sectorId)
  @IntConverter()
  final String sectorId;

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.statusBoolean)
  final bool statusBoolean;

  Map<String, dynamic> toJson() => _$SectorSwitchedOnToJson(this);

  factory SectorSwitchedOn.fromJson(Map<String, dynamic> json) =>
      _$SectorSwitchedOnFromJson(json);

  factory SectorSwitchedOn.fromEntity(MqttSectorSwitchedOn? entity) {
    return SectorSwitchedOn(
      id: entity?.id.toString() ?? '',
      sectorId: entity?.id?.toString() ?? '',
      statusBoolean: entity?.item?.statusBoolean ?? false,
    );
  }

  factory SectorSwitchedOn.fromSectorStatus(SectorStatus? status) {
    return SectorSwitchedOn(
      id: status?.sectorId ?? '',
      sectorId: status?.sectorId ?? '',
      statusBoolean: status?.statusBoolean ?? false,
    );
  }

  MqttSectorSwitchedOn toEntity() {
    final item = MqttItemSwitchedOn() 
      ..statusBoolean = statusBoolean;

    return MqttSectorSwitchedOn()
      ..id = int.tryParse(sectorId)
      ..item = item;
  }
}

extension SectorsSwitchedOnExt on List<SectorSwitchedOn> {
  List<MqttSectorSwitchedOn> toEntities() {
    return map((e) => e.toEntity()).toList();
  }
}
