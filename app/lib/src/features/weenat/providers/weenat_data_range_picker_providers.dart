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
    ),
    const WeenatDataRangeOption(
      locKey: 'weenatLast24Hours',
      daysDifference: 1,
    ),
    const WeenatDataRangeOption(
      locKey: 'weenatLastHour',
      daysDifference: 0,
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
    return options.first;
  }

  void setSelected(WeenatDataRangeOption? option) => state = option;
}