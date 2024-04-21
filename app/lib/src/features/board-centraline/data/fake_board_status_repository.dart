import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_board_statuses.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';


class FakeBoardStatusRepository implements BoardStatusRepository {
  FakeBoardStatusRepository({this.addDelay = true});
  final bool addDelay;

  final _boardStatusesState =
      InMemoryStore<List<BoardStatus>>(kFakeBoardStatuses);

  Stream<List<BoardStatus>> get _statusStream => _boardStatusesState.stream;

  static BoardStatus? _getMostRecentBoardStatus(
      List<BoardStatus> statuses, String boardID) {
    statuses.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return statuses.firstWhereOrNull((st) => st.boardId == boardID);
  }

  @override
  Stream<BoardStatus?> watchBoardStatus(String boardID) {
    return _statusStream.map((statuses) {
      return _getMostRecentBoardStatus(statuses, boardID);
    });
  }

  void dispose() => _boardStatusesState.close();
}
