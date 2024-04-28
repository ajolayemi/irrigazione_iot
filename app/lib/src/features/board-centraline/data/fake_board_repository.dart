import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_boards.dart';
import 'package:irrigazione_iot/src/config/mock/fake_collectors.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeBoardRepository implements BoardRepository {
  FakeBoardRepository({this.addDelay = true});
  final bool addDelay;

  final _boardState = InMemoryStore<List<Board>>(kFakeBoards);

  List<Board> get _boards => _boardState.value;

  Stream<List<Board>> get _streamBoards => _boardState.stream;

  static List<Board> _getBoardsByCompanyID(
      List<Board> boards, String companyID) {
    return boards.where((board) => board.companyId == companyID).toList();
  }

  static Board? _getBoardsByCollectorID(
      List<Board> boards, String collectorID) {
    return boards.firstWhereOrNull((board) => board.collectorId == collectorID);
  }

  static Board? _getBoardsByBoardID(List<Board> boards, String boardID) {
    return boards.firstWhereOrNull((board) => board.id == boardID);
  }

  @override
  Future<Board?> createBoard({required Board board}) async {
    await delay(addDelay);
    final lastId = _boards
        .map((e) => int.tryParse(e.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);
    final newBoard = board.copyWith(id: (lastId + 1).toString());
    final currentBoards = [..._boards];
    currentBoards.add(newBoard);
    _boardState.value = currentBoards;
    return _getBoardsByBoardID(_boards, newBoard.id);
  }

  @override
  Future<bool> deleteBoard({required String boardID}) async {
    await delay(addDelay);
    final currentBoards = [..._boards];
    final index = currentBoards.indexWhere((board) => board.id == boardID);
    if (index == -1) return false;
    currentBoards.removeAt(index);
    _boardState.value = currentBoards;
    return _getBoardsByBoardID(_boards, boardID) == null;
  }

  @override
  Future<Board?> updateBoard({required Board board}) async {
    await delay(addDelay);
    final currentBoards = [..._boards];
    final index = currentBoards.indexWhere((b) => b.id == board.id);
    if (index == -1) return null;
    currentBoards[index] = board;
    _boardState.value = currentBoards;
    return _getBoardsByBoardID(_boards, board.id);
  }

  @override
  Stream<Board?> watchBoardByCollectorID({required String collectorID}) {
    return _streamBoards
        .map((boards) => _getBoardsByCollectorID(boards, collectorID));
  }

  @override
  Stream<List<Board?>> watchBoardsByCompanyID({required String companyID}) {
    return _streamBoards
        .map((boards) => _getBoardsByCompanyID(boards, companyID));
  }

  @override
  Stream<Board?> watchBoardByBoardID({required String boardID}) {
    return _streamBoards.map((boards) => _getBoardsByBoardID(boards, boardID));
  }

  void dispose() => _boardState.close();

  @override
  Future<List<Collector>?> getAvailableCollectors(
      {required String companyId, String? alreadyConnectedCollectorId}) {
    return Future.value(kFakeCollectors
        .where((collector) => collector.companyId == companyId)
        .where((collector) => collector.id != alreadyConnectedCollectorId)
        .toList());
  }

  @override
  Stream<List<String?>> watchCompanyUsedBoardNames(String companyId) {
    return _streamBoards.map(
      (boards) => boards
          .where((board) => board.companyId == companyId)
          .map((board) => board.name.toLowerCase())
          .toList(),
    );
  }
  
  @override
  Stream<List<String>?> watchBoardsUsedMqttNames() {
    return _streamBoards.map(
      (boards) => boards.map((board) => board.mqttMsgName.toLowerCase()).toList(),
    );
  }
}
