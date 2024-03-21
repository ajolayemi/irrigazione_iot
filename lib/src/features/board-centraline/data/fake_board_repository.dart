import 'package:collection/collection.dart';
import 'package:irrigazione_iot/src/config/mock/fake_boards.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:irrigazione_iot/src/utils/in_memory_store.dart';

class FakeBoardRepository implements BoardRepository {
  FakeBoardRepository({this.addDelay = true});
  final bool addDelay;

  final _boardState = InMemoryStore<List<Board>>(kFakeBoards);

  List<Board> get _boards => _boardState.value;

  Stream<List<Board>> get _streamBoards => _boardState.stream;

  static List<Board> _getBoardsByCompanyID(
      List<Board> boards, CompanyID companyID) {
    return boards.where((board) => board.companyId == companyID).toList();
  }

  static Board? _getBoardsByCollectorID(
      List<Board> boards, CollectorID collectorID) {
    return boards.firstWhereOrNull((board) => board.collectorId == collectorID);
  }

  static Board? _getBoardsByBoardID(List<Board> boards, BoardID boardID) {
    return boards.firstWhereOrNull((board) => board.id == boardID);
  }

  @override
  Future<Board?> addBoard({required Board board}) async {
    await delay(addDelay);
    final lastId = _boards
        .map((e) => int.tryParse(e.id) ?? 0)
        .reduce((maxId, currentId) => maxId > currentId ? maxId : currentId);
    final newBoard = board.copyWith(id: (lastId + 1).toString());
    final currentBoards = [..._boards];
    currentBoards.add(newBoard);
    _boardState.value = currentBoards;
    return getBoardByBoardID(boardID: newBoard.id);
  }

  @override
  Future<bool> deleteBoard({required BoardID boardID}) async {
    await delay(addDelay);
    final currentBoards = [..._boards];
    final index = currentBoards.indexWhere((board) => board.id == boardID);
    if (index == -1) return false;
    currentBoards.removeAt(index);
    _boardState.value = currentBoards;
    return await getBoardByBoardID(boardID: boardID) == null;
  }

  @override
  Future<Board?> updateBoard({required Board board}) async {
    await delay(addDelay);
    final currentBoards = [..._boards];
    final index = currentBoards.indexWhere((b) => b.id == board.id);
    if (index == -1) return null;
    currentBoards[index] = board;
    _boardState.value = currentBoards;
    return getBoardByBoardID(boardID: board.id);
  }

  @override
  Future<List<Board>?> geBoardsByCompanyID(
      {required CompanyID companyID}) async {
    await delay(addDelay);
    return _getBoardsByCompanyID(_boards, companyID);
  }

  @override
  Future<Board?> getBoardByCollectorID(
      {required CollectorID collectorID}) async {
    await delay(addDelay);
    return _getBoardsByCollectorID(_boards, collectorID);
  }

  @override
  Stream<Board?> watchBoardByCollectorID({required CollectorID collectorID}) {
    return _streamBoards
        .map((boards) => _getBoardsByCollectorID(boards, collectorID));
  }

  @override
  Stream<List<Board>?> watchBoardsByCompanyID({required CompanyID companyID}) {
    return _streamBoards
        .map((boards) => _getBoardsByCompanyID(boards, companyID));
  }

  @override
  Future<Board?> getBoardByBoardID({required BoardID boardID}) async {
    await delay(addDelay);
    return _getBoardsByBoardID(_boards, boardID);
  }

  @override
  Stream<Board?> watchBoardByBoardID({required BoardID boardID}) {
    return _streamBoards.map((boards) => _getBoardsByBoardID(boards, boardID));
  }

  void dispose() => _boardState.close();
}
