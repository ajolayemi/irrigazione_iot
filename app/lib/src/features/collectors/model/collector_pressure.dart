// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';


class CollectorPressure extends Equatable {
  const CollectorPressure({
    required this.collectorId,
    required this.filterInPressure,
    required this.filterOutPressure,
    required this.timestamp,
  }) : pressureDifference = filterInPressure - filterOutPressure;

  CollectorPressure.empty()
      : collectorId = '',
        filterInPressure = 0.0,
        filterOutPressure = 0.0,
        timestamp = DateTime.fromMillisecondsSinceEpoch(0),
        pressureDifference = 0.0;

  final String collectorId;
  final double filterInPressure;
  final double filterOutPressure;
  final double pressureDifference;
  final DateTime timestamp;

  @override
  List<Object> get props => [
        collectorId,
        filterInPressure,
        filterOutPressure,
        timestamp,
        pressureDifference,
      ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'collectorId': collectorId,
      'filterInPressure': filterInPressure,
      'filterOutPressure': filterOutPressure,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'pressureDifference': pressureDifference
    };
  }

  factory CollectorPressure.fromJson(Map<String, dynamic> map) {
    return CollectorPressure(
      collectorId: map['collectorId'] as String,
      filterInPressure: map['filterInPressure'] as double,
      filterOutPressure: map['filterOutPressure'] as double,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  CollectorPressure copyWith({
    String? collectorId,
    double? filterInPressure,
    double? filterOutPressure,
    DateTime? timestamp,
  }) {
    return CollectorPressure(
      collectorId: collectorId ?? this.collectorId,
      filterInPressure: filterInPressure ?? this.filterInPressure,
      filterOutPressure: filterOutPressure ?? this.filterOutPressure,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
