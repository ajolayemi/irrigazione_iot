import 'package:json_annotation/json_annotation.dart';

part 'history_query_params.g.dart';

@JsonSerializable()
class HistoryQueryParameters {
  const HistoryQueryParameters({
    required this.columnName,
    required this.statisticName,

  });

  final String columnName;
  final String statisticName;

  factory HistoryQueryParameters.fromJson(Map<String, dynamic> json) =>
      _$HistoryQueryParametersFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryQueryParametersToJson(this);
}
