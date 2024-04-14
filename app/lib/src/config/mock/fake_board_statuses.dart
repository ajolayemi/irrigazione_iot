import 'package:irrigazione_iot/src/config/mock/fake_boards.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';

List<BoardStatus> _generateFakeBoardStatuses() {
  List<BoardStatus> boardStatuses = [];
  for (final board in kFakeBoards) {
    for (int i = 0; i < 4; i++) {
      final boardIndex = kFakeBoards.indexOf(board) + 1;
      final lastUpdated = DateTime.now().subtract(Duration(minutes: i));
      final batteryLevel = boardIndex / kFakeBoards.length;
      boardStatuses.add(
        BoardStatus(
          id: 'boardStatus-$boardIndex-$i',
          boardId: board.id,
          batteryLevel: batteryLevel.toDouble(),
          createdAt: lastUpdated,
        ),
      );
    }
  }
  return boardStatuses;
}

final kFakeBoardStatuses = _generateFakeBoardStatuses();
