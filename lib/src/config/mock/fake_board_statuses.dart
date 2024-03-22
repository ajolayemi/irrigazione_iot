import 'package:irrigazione_iot/src/config/mock/fake_boards.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';

List<BoardStatus> _generateFakeBoardStatuses() {
  List<BoardStatus> boardStatuses = [];
  for (final board in kFakeBoards) {
    for (int i = 0; i < 4; i++) {
      final lastUpdated = DateTime.now().subtract(Duration(minutes: i));
      final batteryLevel = (5.0 - 3.0) *
          (0.5 - 0.5 * (lastUpdated.second % 60) / 30).clamp(0.0, 1.0);
      boardStatuses.add(
        BoardStatus(
          boardID: board.id,
          batteryLevel: batteryLevel.toDouble(),
          lastUpdated: lastUpdated,
        ),
      );
    }
  }
  return boardStatuses;
}

final kFakeBoardStatuses = _generateFakeBoardStatuses();
