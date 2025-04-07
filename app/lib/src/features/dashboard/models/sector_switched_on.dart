import 'package:irrigazione_iot/src/features/dashboard/models/sector_switched_on_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sector_switched_on.g.dart';

@JsonSerializable()
class SectorSwitchedOn {
  SectorSwitchedOn({
    required this.id,
    required this.sectorId,
    required this.companyId,
    required this.statusBoolean,
  });

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.id)
  @IntConverter()
  final String id;

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.sectorId)
  @IntConverter()
  final String sectorId;

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.companyId)
  @IntConverter()
  final String companyId;

  @JsonKey(name: SectorSwitchedOnDatabaseKeys.statusBoolean)
  final bool statusBoolean;

  Map<String, dynamic> toJson() => _$SectorSwitchedOnToJson(this);

  factory SectorSwitchedOn.fromJson(Map<String, dynamic> json) =>
      _$SectorSwitchedOnFromJson(json);
}
