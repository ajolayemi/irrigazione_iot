import 'package:irrigazione_iot/src/features/board-centraline/data/fake_board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_repository.g.dart';

/// A [Board] is "centraline" in italian and refers to the arduino boards
/// that are connected to the server (mainly nodered)
/// This repository is responsible for managing the boards.
abstract class BoardRepository {
  /// Fetches a list of boards, if any, pertaining to the company specified with
  /// [CompanyID]
  Future<List<Board>?> geBoardsByCompanyID({
    required CompanyID companyID,
  });

  /// Emits a list of boards, if any, pertaining to the company specified with
  /// [CompanyID]
  Stream<List<Board>?> watchBoardsByCompanyID({
    required CompanyID companyID,
  });

  /// Fetches the [Board] associated with a collector specified by [CollectorID]
  Future<Board?> getBoardByCollectorID({
    required CollectorID collectorID,
  });

  /// Emits the [Board] associated with a collector specified by [CollectorID]
  Stream<Board?> watchBoardByCollectorID({
    required CollectorID collectorID,
  });

  /// Fetches the [Board] associated with [BoardId]
  Future<Board?> getBoardByBoardID({
    required BoardID boardID,
  });

  /// Emits the [Board] associated with [BoardId]
  Stream<Board?> watchBoardByBoardID({
    required BoardID boardID,
  });

  /// Add a new [Board] to the database and returns the newly added [Board] if successful
  Future<Board?> addBoard({
    required Board board,
  });

  /// Update an existing [Board] in the database and returns the updated [Board] if successful
  Future<Board?> updateBoard({
    required Board board,
  });

  /// Delete a [Board] from the database and returns true if successful
  Future<bool> deleteBoard({
    required BoardID boardID,
  });
}

@Riverpod(keepAlive: true)
BoardRepository boardRepository(BoardRepositoryRef ref) {
  // TODO return remote repository as default
  return FakeBoardRepository();
}

@riverpod
Stream<List<Board>?> boardListStream(BoardListStreamRef ref) {
  final boardRepository = ref.read(boardRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return const Stream.empty();
  return boardRepository.watchBoardsByCompanyID(companyID: companyId);
}

@riverpod
Future<List<Board>?> boardListFuture(BoardListFutureRef ref) {
  final boardRepository = ref.read(boardRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Future.value([]);
  return boardRepository.geBoardsByCompanyID(companyID: companyId);
}

@riverpod
Stream<Board?> collectorBoardStream(CollectorBoardStreamRef ref,
    {required CollectorID collectorID}) {
  final boardRepository = ref.read(boardRepositoryProvider);
  return boardRepository.watchBoardByCollectorID(collectorID: collectorID);
}

@riverpod
Future<Board?> collectorBoardFuture(CollectorBoardFutureRef ref,
    {required CollectorID collectorID}) {
  final boardRepository = ref.read(boardRepositoryProvider);
  return boardRepository.getBoardByCollectorID(collectorID: collectorID);
}

@riverpod
Stream<Board?> boardStream(BoardStreamRef ref, {required BoardID boardID}) {
  final boardRepository = ref.watch(boardRepositoryProvider);
  return boardRepository.watchBoardByBoardID(boardID: boardID);
}

@riverpod
Future<Board?> boardFuture(BoardFutureRef ref, {required BoardID boardID}) {
  final boardRepository = ref.watch(boardRepositoryProvider);
  return boardRepository.getBoardByBoardID(boardID: boardID);
}
