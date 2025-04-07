import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/weenat_plot_entity.dart';

part 'weenat_org.freezed.dart';
part 'weenat_org.g.dart';

@freezed
class WeenatOrg with _$WeenatOrg {
  const WeenatOrg._();
  @JsonSerializable(explicitToJson: true)
  const factory WeenatOrg({
    int? id,
    String? name,
  }) = _WeenatOrg;

  factory WeenatOrg.fromJson(Map<String, dynamic> json) =>
      _$WeenatOrgFromJson(json);

  WeenatOrgEntity toEntity() {
    return WeenatOrgEntity()
      ..id = id
      ..name = name;
  }

  factory WeenatOrg.fromEntity(WeenatOrgEntity? entity) {
    if (entity == null) return const WeenatOrg();

    return WeenatOrg(
      id: entity.id,
      name: entity.name,
    );
  }
}

extension WeenatPlotOrgsX on List<WeenatOrg> {
  List<WeenatOrgEntity> toEntities() {
    return map((org) => org.toEntity()).toList();
  }

  List<WeenatOrg> fromEntities(List<WeenatOrgEntity> entities) {
    return entities.map((entity) => WeenatOrg.fromEntity(entity)).toList();
  }

  List<String> toNames() {
    return map((org) => org.name ?? '').toList();
  }
}

extension WeenatPlotOrgEntitiesX on List<WeenatOrgEntity> {
  List<WeenatOrg> toModels(List<WeenatOrgEntity> entities) {
    return entities.map((entity) => WeenatOrg.fromEntity(entity)).toList();
  }
}
