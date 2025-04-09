import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_org.dart';
import 'package:collection/collection.dart';
part 'weenat_plot.freezed.dart';
part 'weenat_plot.g.dart';

@freezed
abstract class WeenatPlot with _$WeenatPlot {
  const WeenatPlot._();

  @JsonSerializable(explicitToJson: true)
  const factory WeenatPlot({
    int? id,
    String? name,
    @JsonKey(name: 'latitude') double? lat,
    @JsonKey(name: 'longitude') double? lng,
    @JsonKey(name: 'organization') WeenatOrg? org,
    @JsonKey(name: 'device_count') int? deviceCount,
    DateTime? lastUpdate,
  }) = _WeenatPlot;

  factory WeenatPlot.fromJson(Map<String, dynamic> json) => _$WeenatPlotFromJson(json);
}

extension WeenatPlotsX on List<WeenatPlot> {
  /// Builds a set of [Marker]s from the list of [WeenatPlot]s
  /// for use in Google Maps
  Set<Marker> toMarkers({
    BitmapDescriptor? selectedIcon,
    BitmapDescriptor? unselectedIcon,
    int? selectedPlotId,
    Function(WeenatPlot? plot, int? plotIndex)? onTap,
  }) {
    const defaultMarker = BitmapDescriptor.defaultMarker;
    return mapIndexed((index, plot) {
      final isSelected = selectedPlotId == plot.id;

      return Marker(
        markerId: MarkerId(plot.id.toString()),
        position: LatLng(plot.lat ?? 0, plot.lng ?? 0),
        icon: isSelected ? selectedIcon ?? defaultMarker : unselectedIcon ?? defaultMarker,
        onTap: () => onTap?.call(plot, index),
      );
    }).toSet();
  }
}
