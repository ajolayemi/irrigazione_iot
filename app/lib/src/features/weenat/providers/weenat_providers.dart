// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_plot_carousel_providers.dart';
import 'package:irrigazione_iot/src/utils/weenat_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/config/enums/weenat_sensor_data_types.dart';
import 'package:irrigazione_iot/src/data/datasource/dao/weenat_dao.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_org.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot_sensor_data.dart';
import 'package:irrigazione_iot/src/features/weenat/services/weenat_service.dart';
import 'package:irrigazione_iot/src/shared/services/shared_preferences_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'weenat_providers.g.dart';

/// Holds onto the current available weenat token retrieved from
///
/// shared preferences
@Riverpod(keepAlive: true)
FutureOr<String?> weenatToken(WeenatTokenRef ref) {
  final prefService = ref.watch(sharedPrefsServiceProvider);
  final uid = ref.watch(authRepositoryProvider).currentUser?.uid;
  return prefService.getUserWeenatToken(uid: uid);
}

@Riverpod(keepAlive: true)
bool hasWeenatToken(HasWeenatTokenRef ref) {
  final token = ref.watch(weenatTokenProvider).valueOrNull;
  return token != null && token.isNotEmpty;
}

/// Access local database to retrieve list of available
/// [WeenatOrg]s
@Riverpod(keepAlive: true)
FutureOr<List<WeenatOrg>?> weenatOrgs(WeenatOrgsRef ref) async {
  final dao = ref.watch(weenatDaoProvider);
  final entities = await dao.getWeenatOrgs() ?? [];
  return entities.toModels(entities);
}

/// Holds onto the current selected [WeenatOrg]
@Riverpod(keepAlive: true)
class SelectedWeenatOrg extends _$SelectedWeenatOrg {
  @override
  WeenatOrg? build() {
    final orgs = ref.watch(weenatOrgsProvider).valueOrNull;
    if (orgs == null || orgs.isEmpty) return null;
    return orgs.first;
  }

  void setSelected(WeenatOrg? org) => state = org;
}

/// Holds onto the index of the selected [WeenatOrg]
@Riverpod(keepAlive: true)
int? selectedOrgIndex(SelectedOrgIndexRef ref) {
  final orgs = ref.watch(weenatOrgsProvider).valueOrNull;
  final selectedOrg = ref.watch(selectedWeenatOrgProvider);
  if (orgs == null || orgs.isEmpty || selectedOrg == null) return null;
  return orgs.indexOf(selectedOrg);
}

/// Access local database to retrieve list of available
/// [WeenatPlot]s for the selected [WeenatOrg]
@Riverpod(keepAlive: true)
FutureOr<List<WeenatPlot>?> weenatPlotsForOrg(WeenatPlotsForOrgRef ref) async {
  final orgId = ref.watch(selectedWeenatOrgProvider.select((val) => val?.id));
  final dao = ref.watch(weenatDaoProvider);
  final entities = await dao.getWeenatPlotsForOrg(orgId) ?? [];
  return entities.toModels(entities);
}

/// Holds onto the static lists of available tensiometers ranges
@Riverpod(keepAlive: true)
List<String> tensiometerRanges(TensiometerRangesRef ref) {
  return ['15', '20', '45'];
}

/// Holds onto the current selected tensiometer range
@Riverpod(keepAlive: true)
class SelectedTensiometerRange extends _$SelectedTensiometerRange {
  @override
  String? build() {
    final ranges = ref.watch(tensiometerRangesProvider);
    if (ranges.isEmpty) return null;
    return ranges.first;
  }

  void setSelected(String? range) => state = range;
}

/// Checks to see if a tensiometer range is selected
@Riverpod(keepAlive: true)
bool tensiometerRangeIsSelected(
  TensiometerRangeIsSelectedRef ref,
  String range,
) {
  return ref.watch(selectedTensiometerRangeProvider) == range;
}

/// Holds onto the selected marker icon
@Riverpod(keepAlive: true)
FutureOr<BitmapDescriptor> selectedMarkerIcon(SelectedMarkerIconRef ref) {
  return WeenatUtils.getPlotSelectedIcon();
}

/// Holds onto the unselected marker icon
/// for the map
@Riverpod(keepAlive: true)
FutureOr<BitmapDescriptor> unselectedMarkerIcon(UnselectedMarkerIconRef ref) {
  return WeenatUtils.getPlotUnselectedIcon();
}

/// Holds onto the list of [Marker]s to be displayed on the map
/// for the selected [WeenatOrg]
@Riverpod(keepAlive: true)
Set<Marker> weenatMapMarkers(WeenatMapMarkersRef ref) {
  final selectedIcon = ref.watch(selectedMarkerIconProvider).valueOrNull;
  final unselectedIcon = ref.watch(unselectedMarkerIconProvider).valueOrNull;
  final plots = ref.watch(weenatPlotsForOrgProvider).valueOrNull;

  final selectedPlotId = ref.watch(
    selectedPlotProvider.select(
      (plot) => plot?.id,
    ),
  );
  if (plots != null && plots.isNotEmpty) {
    return plots.toMarkers(
      selectedIcon: selectedIcon,
      unselectedIcon: unselectedIcon,
      selectedPlotId: selectedPlotId,
      onTap: (plot, index) {
        if (index == null || plot == null) {
          return;
        }
        ref.read(selectedPlotIndexProvider.notifier).setSelected(index);
        WeenatUtils.scrollCarousel(
          index: index,
          scrollController: ref.read(itemScrollControllerProvider),
        );
        WeenatUtils.moveCamera(
          item: plot,
          mapController: ref.read(mapControllerProvider),
        );
      },
    );
  }
  return {};
}

/// Holds onto the currently selected [Marker] on the map
@Riverpod(keepAlive: true)
class SelectedMarker extends _$SelectedMarker {
  @override
  Marker? build() {
    final plots = ref.watch(weenatPlotsForOrgProvider).valueOrNull;
    final markers = plots?.toMarkers() ?? {};
    final selectedPlotId = ref.watch(
      selectedPlotProvider.select(
        (plot) => plot?.id,
      ),
    );
    if (markers.isEmpty || selectedPlotId == null) return null;
    return markers.firstWhere(
        (marker) => marker.markerId.value == selectedPlotId.toString());
  }
}

/// Holds onto the current [GoogleMapController] for the map
@Riverpod(keepAlive: true)
class MapController extends _$MapController {
  @override
  GoogleMapController? build() {
    return null;
  }

  void setController(GoogleMapController? controller) {
    state = controller;
  }
}

/// Holds onto the current [ItemScrollController]
@Riverpod(keepAlive: true)
ItemScrollController itemScrollController(ItemScrollControllerRef ref) {
  return ItemScrollController();
}

/// Holds onto the list of retrieved sensor data for a given plot in a given org
@Riverpod(keepAlive: true)
FutureOr<List<WeenatPlotSensorData>?> plotSensorData(
  PlotSensorDataRef ref, {
  required DateTime start,
  required DateTime end,
  required WeenatSensorDataType type,
  int? plotId,
  int? depth,
}) {
  // Get the current time
  DateTime now = DateTime.now();

  // Calculate the time remaining until the next hour
  DateTime nextHour = DateTime(now.year, now.month, now.day, now.hour + 1);
  Duration timeUntilNextHour = nextHour.difference(now);

  // Start a timer that will run once the time remaining until the next hour has passed
  final timer = Timer.periodic(timeUntilNextHour, (timer) {
    // Invalidate the provider to force a refresh
    ref.invalidateSelf();
  });

  ref.onDispose(() {
    timer.cancel();
  });
  final service = ref.watch(weenatServiceProvider);

  if (plotId == null || depth == null) return [];
  return service.getPlotSensorData(
    from: start,
    to: end,
    plotId: plotId,
    type: type,
    depth: depth,
  );
}
