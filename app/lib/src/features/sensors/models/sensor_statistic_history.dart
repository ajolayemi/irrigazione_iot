import 'package:json_annotation/json_annotation.dart';

part 'sensor_statistic_history.g.dart';

@JsonSerializable()
class SensorStatisticHistory {
  const SensorStatisticHistory({
    required this.value,
    this.createdAt,
  });
  final num value;
  final DateTime? createdAt;

  factory SensorStatisticHistory.fromJson(Map<String, dynamic> json) =>
      _$SensorStatisticHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$SensorStatisticHistoryToJson(this);
}