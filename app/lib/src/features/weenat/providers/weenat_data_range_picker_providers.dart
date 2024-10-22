import 'package:irrigazione_iot/src/config/enums/weenat_sensor_data_types.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_data_range_option.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weenat_data_range_picker_providers.g.dart';

/// Holds onto the static list of [WeenatDataRangeOption]s
@Riverpod(keepAlive: true)
List<WeenatDataRangeOption> dataRangeOptions(DataRangeOptionsRef ref) {
  return [
    const WeenatDataRangeOption(
      locKey: 'weenatLast7Days',
      daysDifference: 7,
      type: WeenatDataRangeType.last7Days,
    ),
    const WeenatDataRangeOption(
      locKey: 'weenatLast24Hours',
      daysDifference: 1,
      type: WeenatDataRangeType.yesterday,
    ),
    const WeenatDataRangeOption(
      locKey: 'weenatLastHour',
      daysDifference: 0,
      type: WeenatDataRangeType.lastHour,
    ),
  ];
}

/// Holds onto the current selected [WeenatDataRangeOption]
@Riverpod(keepAlive: true)
class SelectedDataRangeOption extends _$SelectedDataRangeOption {
  @override
  WeenatDataRangeOption? build() {
    final options = ref.watch(dataRangeOptionsProvider);
    if (options.isEmpty) return null;
    final index = options.indexWhere(
      (element) => element.type == WeenatDataRangeType.lastHour,
    );

    if (index == -1) return options.first;

    return options[index];
  }

  void setSelected(WeenatDataRangeOption? option) => state = option;
}
