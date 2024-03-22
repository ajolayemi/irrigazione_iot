import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_board_statuses.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeBoardStatusRepository implements BoardStatusRepository {
  FakeBoardStatusRepository({this.addDelay = true});
  final bool addDelay;

  final _boardStatusesState =
      InMemoryStore<List<BoardStatus>>(kFakeBoardStatuses);

  List<BoardStatus> get _statusValue => _boardStatusesState.value;

  Stream<List<BoardStatus>> get _statusStream => _boardStatusesState.stream;

  static BoardStatus? _getMostRecentBoardStatus(
      List<BoardStatus> statuses, BoardID boardID) {
    statuses.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
    return statuses.firstWhereOrNull((st) => st.boardID == boardID);
  }

  @override
  Future<BoardStatus?> getBoardStatus(BoardID boardID) async {
    await delay(addDelay);
    return _getMostRecentBoardStatus(_statusValue, boardID);
  }

  @override
  Stream<BoardStatus?> watchBoardStatus(BoardID boardID) {
    return _statusStream.map((statuses) {
      return _getMostRecentBoardStatus(statuses, boardID);
    });
  }

  void dispose() => _boardStatusesState.close();
}
