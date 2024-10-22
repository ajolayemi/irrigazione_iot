import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/enums/weenat_sensor_data_types.dart';
import 'package:irrigazione_iot/src/config/theme/app_colors_palette.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_data_range_option.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_data_range_picker_providers.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/utils/extensions/loc_extensions.dart';

class WeenatMeasurementContainers extends ConsumerWidget {
  const WeenatMeasurementContainers({
    super.key,
    this.plotId,
  });

  final int? plotId;

  DateTime _getStartDate({
    required DateTime today,
    required WeenatDataRangeOption option,
  }) {
    final todayAtMidnight = DateTime(
      today.year,
      today.month,
      today.day,
    );

    if (option.type == WeenatDataRangeType.lastHour) {
      return today.subtract(const Duration(hours: 1));
    }

    return todayAtMidnight.subtract(Duration(days: option.daysDifference));
  }

  DateTime _getEndDate({
    required DateTime startDate,
    required WeenatDataRangeOption option,
  }) {
    

    return startDate.add(const Duration(hours: 1));
  }

  String _buildTime(DateTime? date) {
    if (date == null) return '00:00';
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(dataRangeOptionsProvider);
    final textTheme = context.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...options.mapIndexed((index, item) {
          return Consumer(
            builder: (context, ref, child) {
              final selectedOption = ref.watch(selectedDataRangeOptionProvider);
              return GestureDetector(
                onTap: () {
                  ref
                      .read(selectedDataRangeOptionProvider.notifier)
                      .setSelected(item);
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    final today = DateTime.now();
                    final cleanedToday = DateTime(
                      today.year,
                      today.month,
                      today.day,
                      today.hour,
                    );
                    final startDate = _getStartDate(
                      today: cleanedToday,
                      option: item,
                    );

                    final endDate = _getEndDate(
                      startDate: startDate,
                      option: item,
                    );

                    final depth = ref.watch(selectedTensiometerRangeProvider);
                    final data = ref
                            .watch(
                              plotSensorDataProvider(
                                start: startDate,
                                end: endDate,
                                type: WeenatSensorDataType.waterPotential,
                                plotId: plotId,
                                depth: int.tryParse(depth ?? ''),
                              ),
                            )
                            .valueOrNull ??
                        [];

                    final firstData = data.firstOrNull;
                    return Container(
                      width: 80,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.p8,
                        vertical: Sizes.p8,
                      ),
                      margin: const EdgeInsets.only(right: Sizes.p8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedOption == item
                              ? AppColorsPalette.lightGreen
                              : AppColorsPalette.grey2,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(context.getLocByKey(item.locKey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textScaler: const TextScaler.linear(1),
                              style:
                                  textTheme.labelSmall?.copyWith(fontSize: 10)),
                          gapH4,
                          Text(
                            _buildTime(firstData?.timeStamp),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textScaler: const TextScaler.linear(1),
                            style: textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                              color: AppColorsPalette.grey4,
                            ),
                          ),
                          const Spacer(),
                          Text('${firstData?.sensorData ?? '0'} kPa',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textScaler: const TextScaler.linear(1),
                              style: textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                              )),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        })
      ],
    );
  }
}
