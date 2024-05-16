import 'package:json_annotation/json_annotation.dart';

part 'weather_station_statistic_history.g.dart';

@JsonSerializable()
class WeatherStationStatisticHistory {
  const WeatherStationStatisticHistory({
    required this.value,
    this.createdAt,
  });
  final num value;
  final DateTime? createdAt;

  factory WeatherStationStatisticHistory.fromJson(Map<String, dynamic> json) =>
      _$WeatherStationStatisticHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStationStatisticHistoryToJson(this);
}
