import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irrigazione_iot/src/config/enums/weenat_sensor_data_types.dart';

part 'weenat_data_range_option.freezed.dart';

@freezed
class WeenatDataRangeOption with _$WeenatDataRangeOption {
  const WeenatDataRangeOption._();

  const factory WeenatDataRangeOption({
    required String locKey,
    required int daysDifference,
    required WeenatDataRangeType type,
  }) = _WeenatDataRangeOption;
}
