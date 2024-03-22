import 'package:irrigazione_iot/src/config/mock/fake_boards.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';

List<BoardStatus> _generateFakeBoardStatuses() {
  List<BoardStatus> boardStatuses = [];
  for (final board in kFakeBoards) {
    final lastUpdated = DateTime.now().subtract(const Duration(minutes: 1));
    final batteryLevel = 100 - int.parse(board.id) * 10;
    boardStatuses.add(BoardStatus(
        boardID: board.id,
        batteryLevel: batteryLevel.toDouble(),
        lastUpdated: lastUpdated));
  }
  return boardStatuses;
}


final kFakeBoardStatuses = _generateFakeBoardStatuses();