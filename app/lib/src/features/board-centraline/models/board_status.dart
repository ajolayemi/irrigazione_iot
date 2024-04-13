// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';


class BoardStatus extends Equatable {
  const BoardStatus({
    required this.boardID,
    required this.batteryLevel,
    required this.lastUpdated,
  });

  BoardStatus.empty()
      : boardID = '',
        batteryLevel = 0,
        lastUpdated = DateTime.fromMillisecondsSinceEpoch(0);

  final String boardID;
  final double batteryLevel;
  final DateTime lastUpdated;

  @override
  List<Object> get props => [boardID, batteryLevel, lastUpdated];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'boardID': boardID,
      'batteryLevel': batteryLevel,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory BoardStatus.fromMap(Map<String, dynamic> map) {
    return BoardStatus(
      boardID: map['boardID'] as String,
      batteryLevel: map['batteryLevel'] as double,
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['lastUpdated'] as int),
    );
  }

  BoardStatus copyWith({
    String? boardID,
    double? batteryLevel,
    DateTime? lastUpdated,
  }) {
    return BoardStatus(
      boardID: boardID ?? this.boardID,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
