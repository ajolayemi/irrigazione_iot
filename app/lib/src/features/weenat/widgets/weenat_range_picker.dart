import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/config/theme/app_colors_palette.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_data_range_option.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_data_range_picker_providers.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/utils/extensions/loc_extensions.dart';

class WeenatRangePicker extends ConsumerWidget {
  const WeenatRangePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(dataRangeOptionsProvider);
    return Container(
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColorsPalette.grey4,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...options.mapIndexed(
            (index, item) {
              return Consumer(
                builder: (context, ref, child) {
                  final isSelected =
                      ref.watch(selectedDataRangeOptionProvider) == item;
                  final isFirstItem = index == 0;
                  final isLastItem = index == options.length - 1;
                  return WeenatRangePickerItem(
                    value: item,
                    label: context.getLocByKey(item.locKey),
                    isSelected: isSelected,
                    isFirstItem: isFirstItem,
                    isLastItem: isLastItem,
                    onTap: ref
                        .read(selectedDataRangeOptionProvider.notifier)
                        .setSelected,
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class WeenatRangePickerItem extends StatelessWidget {
  const WeenatRangePickerItem({
    super.key,
    required this.label,
    required this.value,
    required this.isSelected,
    this.onTap,
    this.isFirstItem = false,
    this.isLastItem = false,
  });

  final String label;
  final WeenatDataRangeOption value;
  final bool isSelected;
  final Function(WeenatDataRangeOption?)? onTap;
  final bool isFirstItem;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return InkWell(
      onTap: () => onTap?.call(value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.p16,
          vertical: Sizes.p8,
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColorsPalette.lightGreen : AppColorsPalette.white,
          borderRadius: isFirstItem
              ? const BorderRadius.only(
                  topLeft: Radius.circular(
                    Sizes.p8,
                  ),
                  bottomLeft: Radius.circular(
                    Sizes.p8,
                  ),
                )
              : isLastItem
                  ? const BorderRadius.only(
                      bottomRight: Radius.circular(
                        Sizes.p8,
                      ),
                      topRight: Radius.circular(
                        Sizes.p8,
                      ),
                    )
                  : BorderRadius.circular(0),
        ),
        child: SizedBox(
          width: 80,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium?.copyWith(
              color:
                  isSelected ? AppColorsPalette.white : AppColorsPalette.grey8,
            ),
          ),
        ),
      ),
    );
  }
}
