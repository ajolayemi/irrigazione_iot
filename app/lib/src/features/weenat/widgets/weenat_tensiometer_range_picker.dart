import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/config/theme/app_colors_palette.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
import 'package:irrigazione_iot/src/features/weenat/widgets/weenat_tensiometer_range_picker_item.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class WeenatTensiometerRangePicker extends ConsumerWidget {
  const WeenatTensiometerRangePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    final ranges = ref.watch(tensiometerRangesProvider);
    return Align(
      alignment: Alignment.topRight,
      child: Row(
   
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              loc.tensiometerDepth,
              textScaler: const TextScaler.linear(1),
              style: textTheme.labelMedium?.copyWith(
                color: AppColorsPalette.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          gapW8,
          Container(
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColorsPalette.grey4,
                width: 1,
              ),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...ranges.mapIndexed(
                  (index, item) {
                    return Consumer(
                      builder: (context, ref, child) {
                        final isSelected = ref.watch(
                          tensiometerRangeIsSelectedProvider(item),
                        );
                        final isFirstItem = index == 0;
                        final defaultDec = BoxDecoration(
                          color: isSelected
                              ? AppColorsPalette.weenatBlue
                              : AppColorsPalette.white,
                          borderRadius: isFirstItem
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                )
                              : null,
                        );
            
                        return WeenatTensiometerRangePickerItem(
                          label: item.toString(),
                          labelColor: isSelected
                              ? AppColorsPalette.white
                              : AppColorsPalette.grey8,
                          decoration: defaultDec,
                          onTap: (range) {
                            if (range == null || isSelected) return;
                            ref
                                .read(selectedTensiometerRangeProvider.notifier)
                                .setSelected(range);
                          },
                        );
                      },
                    );
                  },
                ).toList(),
                WeenatTensiometerRangePickerItem(
                  label: loc.centimeters,
                  labelColor: AppColorsPalette.white,
                  decoration: const BoxDecoration(
                    color: AppColorsPalette.grey8,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  isClickable: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
