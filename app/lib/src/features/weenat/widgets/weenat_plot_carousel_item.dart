import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/theme/app_colors_palette.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
import 'package:irrigazione_iot/src/features/weenat/widgets/weenat_measurement_containers.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class WeenatPlotCarouselItem extends ConsumerWidget {
  const WeenatPlotCarouselItem({
    super.key,
    required this.plot,
    required this.isFirstItem,
    required this.isLastItem,
    required this.isSelected,
    required this.onSwipeRight,
    required this.onSwipeLeft,
  });

  final WeenatPlot plot;
  final bool isFirstItem;
  final bool isLastItem;
  final bool isSelected;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final loc = context.loc;

    return GestureDetector(
      onPanUpdate: (details) {
        final dx = details.delta.dx;
        if (dx > 0 && !isFirstItem) {
          onSwipeRight();
          return;
        }
        if (dx < 0 && !isLastItem) {
          onSwipeLeft();
          return;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            key: UniqueKey(),
            width: context.screenWidth * 0.9,
            height: 180,
            margin: EdgeInsets.only(
              right: isLastItem ? Sizes.p20 : 0,
              left: Sizes.p16,
            ),
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(Sizes.p16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
              border: isSelected
                  ? Border.all(
                      color: AppColorsPalette.weenatBlue,
                      width: 6,
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.p16,
                  ),
                  child: Text(
                    plot.name ?? '',
                    style: textTheme.labelMedium,
                    textScaler: const TextScaler.linear(1),
                  ),
                ),
                gapH8,
                const Divider(
                  indent: 0,
                  endIndent: 0,
                  thickness: 1,
                  color: AppColorsPalette.grey2,
                ),

                // Plot graph section
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.p16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final selectedRange = ref.watch(
                            selectedTensiometerRangeProvider,
                          );
                          return Container(
                            height: 80,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.p8,
                              vertical: Sizes.p8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColorsPalette.lightGreen,
                              borderRadius: BorderRadius.circular(Sizes.p8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selectedRange ?? '',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: AppColorsPalette.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textScaler: const TextScaler.linear(1),
                                ),
                                gapH4,
                                Text(
                                  loc.centimeters,
                                  style: textTheme.labelSmall?.copyWith(
                                    color: AppColorsPalette.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textScaler: const TextScaler.linear(1),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      gapW12,
                      // Measurements section
                      WeenatMeasurementContainers(
                        plotId: plot.id,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Divider(
                  indent: 0,
                  endIndent: 0,
                  thickness: 1,
                  color: AppColorsPalette.grey2,
                ),
                gapH4,
              ],
            ),
          )
        ],
      ),
    );
  }
}
