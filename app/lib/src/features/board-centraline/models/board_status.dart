// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/features/board-centraline/models/board_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/int_converter.dart';

part 'board_status.g.dart';

@JsonSerializable()
class BoardStatus extends Equatable {
  const BoardStatus({
    required this.id,
    required this.batteryLevel,
    this.createdAt,
    required this.boardId,
  });

  const BoardStatus.empty()
      : id = '',
        batteryLevel = 0,
        createdAt = null,
        boardId = '';

  @JsonKey(name: BoardStatusDatabaseKeys.id, includeToJson: false)
  @IntConverter()
  final String id;

  @JsonKey(name: BoardStatusDatabaseKeys.batteryLevel)
  final double batteryLevel;

  @JsonKey(name: BoardStatusDatabaseKeys.boardId)
  @IntConverter()
  final String boardId;

  @JsonKey(name: BoardStatusDatabaseKeys.createdAt)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, batteryLevel, createdAt, boardId];

  factory BoardStatus.fromJson(Map<String, dynamic> json) =>
      _$BoardStatusFromJson(json);

  Map<String, dynamic> toJson() => _$BoardStatusToJson(this);
}

extension BoardStatusEx on BoardStatus? {
  double get batteryLevelForUi {
    final batteryLevel = this?.batteryLevel ?? 0;

    switch (batteryLevel) {
      case < 11:
        return 5.0;
      case >= 11 && <= 12.1:
        return 25.0;
      case >= 12.2 && <= 12.3:
        return 50.0;
      case >= 12.4 && <= 12.5:
        return 75.0;
      case >= 12.6:
        return 100.0;
      default:
        return 0.0;
    }
  }
}
