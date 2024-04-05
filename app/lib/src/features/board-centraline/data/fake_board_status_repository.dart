import 'package:collection/collection.dart';
import '../../../config/mock/fake_board_statuses.dart';
import 'board_status_repository.dart';
import '../models/board.dart';
import '../models/board_status.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';

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
