import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot_org.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
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
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _selectOrg(int? currentIndex) async {
    if (currentIndex == null) return;
    final orgs = ref.read(weenatPlotOrgsProvider).valueOrNull;

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              left: false,
              right: false,
              top: false,
              child: Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapType: MapType.satellite,
                    mapToolbarEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        37.30876803981336,
                        15.031336292492695,
                      ),
                      zoom: 15,
                    ),
                    onMapCreated: (controller) => _controller = controller,
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
                            final org = ref.watch(selectedWeenatOrgProvider);
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
                                        textScaler: const TextScaler.linear(1),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
