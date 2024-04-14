// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status_database_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'board_status.g.dart';

@JsonSerializable()
class BoardStatus extends Equatable {
  const BoardStatus({
    required this.id,
    required this.batteryLevel,
    required this.createdAt,
    required this.boardId,
  });

  BoardStatus.empty()
      : id = '',
        batteryLevel = 0,
        createdAt = DateTime.parse('2024-01-01'),
        boardId = '';

  @JsonKey(name: BoardStatusDatabaseKeys.id)
  final String id;
  @JsonKey(name: BoardStatusDatabaseKeys.batteryLevel)
  final double batteryLevel;
  @JsonKey(name: BoardStatusDatabaseKeys.createdAt)
  final DateTime createdAt;
  @JsonKey(name: BoardStatusDatabaseKeys.boardId)
  final String boardId;

  @override
  List<Object> get props => [id, batteryLevel, createdAt, boardId];

  BoardStatus copyWith({
    String? id,
    double? batteryLevel,
    DateTime? createdAt,
    String? boardId,
  }) {
    return BoardStatus(
      id: id ?? this.id,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      createdAt: createdAt ?? this.createdAt,
      boardId: boardId ?? this.boardId,
    );
  }

  factory BoardStatus.fromJson(Map<String, dynamic> json) =>
      _$BoardStatusFromJson(json);

  Map<String, dynamic> toJson() => _$BoardStatusToJson(this);
}
