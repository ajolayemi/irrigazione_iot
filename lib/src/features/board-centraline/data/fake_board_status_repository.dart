import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';

class FakeBoardStatusRepository implements BoardStatusRepository {
  @override
  Future<BoardStatus?> getBoardStatus(BoardID boardID) {
    // TODO: implement getBoardStatus
    throw UnimplementedError();
  }

  @override
  Stream<BoardStatus?> watchBoardStatus(BoardID boardID) {
    // TODO: implement watchBoardStatus
    throw UnimplementedError();
  }

}