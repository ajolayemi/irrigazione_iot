import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_org.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_plot_carousel_providers.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
import 'package:irrigazione_iot/src/features/weenat/widgets/weenat_plots_card.dart';
import 'package:irrigazione_iot/src/features/weenat/widgets/weenat_range_picker.dart';
import 'package:irrigazione_iot/src/features/weenat/widgets/weenat_tensiometer_range_picker.dart';
import 'package:irrigazione_iot/src/shared/providers/location_providers.dart';
import 'package:irrigazione_iot/src/shared/services/location_service.dart';
import 'package:irrigazione_iot/src/utils/app_drawer_utils.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class WeenatMapScreen extends ConsumerStatefulWidget {
  const WeenatMapScreen({super.key});

  @override
  ConsumerState<WeenatMapScreen> createState() => _WeenatMapScreenState();
}

class _WeenatMapScreenState extends ConsumerState<WeenatMapScreen> {
  GoogleMapController? _controller;

  @override
  void initState() {
    // Initialize user's location provider
    ref.read(userLocationCoordinatesProvider);
    ref.read(selectedMarkerIconProvider);
    ref.read(unselectedMarkerIconProvider);

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _selectOrg(int? currentIndex) async {
    if (currentIndex == null) return;
    final orgs = ref.read(weenatOrgsProvider).valueOrNull;

    if (orgs == null || orgs.isEmpty) return;
    final index = await AppDrawerUtils.showChoiceSheet(
      context: context,
      title: context.loc.weenatSelectCompany,
      items: orgs.toNames(),
      selectedIndex: currentIndex,
    );

    if (index != null && index != currentIndex) {
      final org = orgs[index];
      ref.read(selectedWeenatOrgProvider.notifier).setSelected(org);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = context.screenTopPadding;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final plots = ref.watch(weenatPlotsForOrgProvider);

    return Scaffold(
      body: plots.when(
        data: (plots) {
          return Column(
            children: [
              Expanded(
                child: SafeArea(
                  left: false,
                  right: false,
                  top: false,
                  child: Stack(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final initialPlot = ref.watch(initialPlotProvider);
                          final markers = ref.watch(weenatMapMarkersProvider);
                          final userLocation = ref
                              .watch(userLocationCoordinatesProvider)
                              .valueOrNull;
                          // TODO: refactor this so that if there is no initial plot
                          // TODO: the map should center on the user's location

                          return GoogleMap(
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                            mapType: MapType.hybrid,
                            mapToolbarEnabled: true,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: initialPlot == null
                                  ? userLocation ??
                                      LocationService.defaultLocation
                                  : LatLng(
                                      initialPlot.lat ?? 37.30876803981336,
                                      initialPlot.lng ?? 15.031336292492695,
                                    ),
                              zoom: 15,
                            ),
                            onMapCreated: (controller) {
                              _controller = controller;
                              ref
                                  .read(mapControllerProvider.notifier)
                                  .setController(controller);
                            },
                            markers: markers,
                          );
                        },
                      ),
                      Positioned(
                        top: topPadding,
                        left: 20,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => context.popNavigator(),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            gapW24,

                            // Org name section with dropdown
                            Consumer(
                              builder: (context, ref, child) {
                                final org =
                                    ref.watch(selectedWeenatOrgProvider);
                                final orgIndex =
                                    ref.watch(selectedOrgIndexProvider);
                                return GestureDetector(
                                  onTap: () => _selectOrg(orgIndex),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    width: context.screenWidth * 0.6,
                                    decoration: BoxDecoration(
                                      color: colorScheme.surface,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        gapW8,
                                        Flexible(
                                          child: Text(
                                            org?.name ?? '',
                                            style: textTheme.bodyMedium,
                                            overflow: TextOverflow.ellipsis,
                                            textScaler:
                                                const TextScaler.linear(1),
                                            maxLines: 1,
                                          ),
                                        ),
                                        gapW24,
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),

                      // Tensiometer range choice, data range choice, and plots cards
                      // section
                      Positioned(
                        bottom: 34,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.p16,
                                ),
                                child: WeenatTensiometerRangePicker(),
                              ),
                              gapH12,
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.p16,
                                ),
                                child: WeenatRangePicker(),
                              ),
                              gapH4,
                              Consumer(
                                builder: (context, ref, child) {
                                  final plots = ref.watch(
                                    weenatPlotsForOrgProvider,
                                  );

                                  return plots.when(
                                    data: (plots) {
                                      return WeenatPlotsCard(
                                        mapController: _controller,
                                        plots: plots ?? [],
                                      );
                                    },
                                    loading: () =>
                                        const CircularProgressIndicator
                                            .adaptive(),
                                    error: (_, __) => const SizedBox.shrink(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }
}
