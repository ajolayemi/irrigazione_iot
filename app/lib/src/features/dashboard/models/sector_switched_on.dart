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
    this.companyId,
  });

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.id)
  @IntConverter()
  final String id;

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.sectorId)
  @IntConverter()
  final String sectorId;

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.statusBoolean)
  final bool statusBoolean;

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.companyId)
  @IntConverter()
  final String? companyId;

  Map<String, dynamic> toJson() => _$SectorSwitchedOnToJson(this);

  factory SectorSwitchedOn.fromJson(Map<String, dynamic> json) =>
      _$SectorSwitchedOnFromJson(json);

  factory SectorSwitchedOn.fromEntity(LocalSectorSwitchedOn? entity) {
    return SectorSwitchedOn(
      id: entity?.id.toString() ?? '',
      sectorId: entity?.id?.toString() ?? '',
      statusBoolean: entity?.item?.statusBoolean ?? false,
      companyId: entity?.item?.companyId,
    );
  }

  factory SectorSwitchedOn.fromSectorStatus(SectorStatus? status) {
    return SectorSwitchedOn(
      id: status?.sectorId ?? '',
      sectorId: status?.sectorId ?? '',
      statusBoolean: status?.statusBoolean ?? false,
      companyId: status?.companyId,
    );
  }

  LocalSectorSwitchedOn toEntity() {
    final item = LocalItemSwitchedOn()
      ..statusBoolean = statusBoolean
      ..companyId = companyId;

    return LocalSectorSwitchedOn()
      ..id = int.tryParse(sectorId)
      ..item = item;
  }
}

extension SectorsSwitchedOnExt on List<SectorSwitchedOn> {
  List<LocalSectorSwitchedOn> toEntities() {
    return map((e) => e.toEntity()).toList();
  }
}
