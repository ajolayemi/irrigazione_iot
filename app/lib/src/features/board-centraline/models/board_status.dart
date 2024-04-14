// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status_database_keys.dart';

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

  final String id;
  final double batteryLevel;
  final DateTime createdAt;
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

  Map<String, dynamic> toJson() {
    return {
      BoardStatusDatabaseKeys.id: id,
      BoardStatusDatabaseKeys.batteryLevel: batteryLevel,
      BoardStatusDatabaseKeys.createdAt: createdAt.toIso8601String(),
      BoardStatusDatabaseKeys.boardId: boardId,
    };
  }

  static BoardStatus fromJson(Map<String, dynamic> json) {
    return BoardStatus(
      id: json[BoardStatusDatabaseKeys.id],
      batteryLevel: json[BoardStatusDatabaseKeys.batteryLevel],
      createdAt: DateTime.parse(json[BoardStatusDatabaseKeys.createdAt]),
      boardId: json[BoardStatusDatabaseKeys.boardId],
    );
  }
}
