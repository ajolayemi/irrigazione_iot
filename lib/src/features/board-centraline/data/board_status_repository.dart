import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';

abstract class BoardStatusRepository {

  /// Fetches the most recent [BoardStatus] for a given [BoardID]
  Future<BoardStatus?> getBoardStatus(BoardID boardID);

  /// Emits the most recent [BoardStatus] for a given [BoardID]
  Stream<BoardStatus?> watchBoardStatus(BoardID boardID);
}