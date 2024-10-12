import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/weenat_plot_entity.dart';

part 'weenat_plot_org.freezed.dart';
part 'weenat_plot_org.g.dart';

@freezed
class WeenatPlotOrg with _$WeenatPlotOrg {
  const WeenatPlotOrg._();
  @JsonSerializable(explicitToJson: true)
  const factory WeenatPlotOrg({
    int? id,
    String? name,
  }) = _WeenatPlotOrg;

  factory WeenatPlotOrg.fromJson(Map<String, dynamic> json) =>
      _$WeenatPlotOrgFromJson(json);

  WeenatPlotOrgEntity toEntity() {
    return WeenatPlotOrgEntity()
      ..id = id
      ..name = name;
  }

  factory WeenatPlotOrg.fromEntity(WeenatPlotOrgEntity? entity) {
    if (entity == null) return const WeenatPlotOrg();

    return WeenatPlotOrg(
      id: entity.id,
      name: entity.name,
    );
  }
}

extension WeenatPlotOrgsX on List<WeenatPlotOrg> {
  List<WeenatPlotOrgEntity> toEntities() {
    return map((org) => org.toEntity()).toList();
  }

  List<WeenatPlotOrg> fromEntities(List<WeenatPlotOrgEntity> entities) {
    return entities.map((entity) => WeenatPlotOrg.fromEntity(entity)).toList();
  }
}


extension WeenatPlotOrgEntitiesX on List<WeenatPlotOrgEntity> {
  List<WeenatPlotOrg> toModels(List<WeenatPlotOrgEntity> entities) {
    return entities.map((entity) => WeenatPlotOrg.fromEntity(entity)).toList();
  }
}