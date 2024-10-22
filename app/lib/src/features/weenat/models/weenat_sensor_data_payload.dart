import 'package:freezed_annotation/freezed_annotation.dart';

part 'weenat_sensor_data_payload.freezed.dart';
part 'weenat_sensor_data_payload.g.dart';

@freezed
class WeenatSensorDataPayload with _$WeenatSensorDataPayload {
  const WeenatSensorDataPayload._();

  const factory WeenatSensorDataPayload({
    required int start,
    required int end,
    @JsonKey(name: 'plot_id') required int plotId,
    int? organization,
  }) = _WeenatSensorDataPayload;

  factory WeenatSensorDataPayload.fromJson(Map<String, dynamic> json) =>
      _$WeenatSensorDataPayloadFromJson(json);
}
