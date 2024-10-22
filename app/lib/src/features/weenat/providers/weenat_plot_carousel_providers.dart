import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weenat_plot_carousel_providers.g.dart';

/// Holds onto the first [WeenatPlot] in the list of [WeenatPlot]s
/// This is used to determine the google maps initial camera position
@Riverpod(keepAlive: true)
WeenatPlot? initialPlot(InitialPlotRef ref) {
  final plots = ref.watch(weenatPlotsForOrgProvider).valueOrNull ?? [];
  return plots.isEmpty ? null : plots.first;
}

/// Holds onto the index of the currently selected [WeenatPlot]
/// This is used to determine the selected plot in the carousel
@Riverpod(keepAlive: true)
class SelectedPlotIndex extends _$SelectedPlotIndex {
  @override
  int? build() {
    final plots = ref.watch(weenatPlotsForOrgProvider).valueOrNull;
    if (plots == null || plots.isEmpty) return null;
    return 0;
  }

  void setSelected(int index) => state = index;
}

/// Holds onto the currently selected [WeenatPlot]
@Riverpod(keepAlive: true)
class SelectedPlot extends _$SelectedPlot {
  @override
  WeenatPlot? build() {
    final plots = ref.watch(weenatPlotsForOrgProvider).valueOrNull;
    final index = ref.watch(selectedPlotIndexProvider) ?? 0;

    if (plots == null || plots.isEmpty) return null;
    return plots[index];
  }

  void setSelected(WeenatPlot? plot) => state = plot;
}
