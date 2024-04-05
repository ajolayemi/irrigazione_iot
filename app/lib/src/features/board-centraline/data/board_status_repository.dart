import 'fake_board_status_repository.dart';
import '../models/board.dart';
import '../models/board_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_status_repository.g.dart';

abstract class BoardStatusRepository {

  /// Fetches the most recent [BoardStatus] for a given [BoardID]
  Future<BoardStatus?> getBoardStatus(BoardID boardID);

  /// Emits the most recent [BoardStatus] for a given [BoardID]
  Stream<BoardStatus?> watchBoardStatus(BoardID boardID);
}

@Riverpod(keepAlive: true)
BoardStatusRepository boardStatusRepository(BoardStatusRepositoryRef ref) {
  // TODO return remote repository as default
  return FakeBoardStatusRepository();
}

@riverpod
Stream<BoardStatus?> boardStatusStream(BoardStatusStreamRef ref, {required BoardID boardID}) {
  final boardStatusRepository = ref.read(boardStatusRepositoryProvider);
  return boardStatusRepository.watchBoardStatus(boardID);
}

@riverpod
Future<BoardStatus?> boardStatusFuture(BoardStatusFutureRef ref, {required BoardID boardID}) {
  final boardStatusRepository = ref.read(boardStatusRepositoryProvider);
  return boardStatusRepository.getBoardStatus(boardID);
}