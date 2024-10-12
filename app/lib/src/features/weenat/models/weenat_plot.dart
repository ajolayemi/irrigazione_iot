import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irrigazione_iot/src/data/datasource/entities/weenat_plot_entity.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot_org.dart';

part 'weenat_plot.freezed.dart';
part 'weenat_plot.g.dart';

@freezed
class WeenatPlot with _$WeenatPlot {
  const WeenatPlot._();

  @JsonSerializable(explicitToJson: true)
  const factory WeenatPlot({
    int? id,
    String? name,
    @JsonKey(name: 'latitude') double? lat,
    @JsonKey(name: 'longitude') double? lng,
    @JsonKey(name: 'organization') WeenatPlotOrg? org,
    @JsonKey(name: 'device_count') int? deviceCount,
    DateTime? lastUpdate,
  }) = _WeenatPlot;

  factory WeenatPlot.fromJson(Map<String, dynamic> json) =>
      _$WeenatPlotFromJson(json);

  /// Translates model class to entity needed for local database
  WeenatPlotEntity toEntity() {
    return WeenatPlotEntity()
      ..id = id
      ..deviceCount = deviceCount
      ..lat = lat
      ..lng = lng
      ..org = org?.toEntity()
      ..name = name
      ..lastUpdate = lastUpdate ?? DateTime.now();
  }

  /// Translates entity class to model class
  factory WeenatPlot.fromEntity(WeenatPlotEntity? entity) {
    if (entity == null) return const WeenatPlot();

    return WeenatPlot(
      id: entity.id,
      deviceCount: entity.deviceCount,
      lat: entity.lat,
      lng: entity.lng,
      name: entity.name,
      org: WeenatPlotOrg.fromEntity(entity.org),
      lastUpdate: entity.lastUpdate,
    );
  }
}

extension WeenatPlotsX on List<WeenatPlot> {
  List<WeenatPlotEntity> toEntities() {
    return map((e) => e.toEntity()).toList();
  }
}

extension WeenatPlotEntitiesX on List<WeenatPlotEntity> {
  List<WeenatPlot> toModels(List<WeenatPlotEntity> entities) {
    return entities.map((entity) => WeenatPlot.fromEntity(entity)).toList();
  }
}