import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/fake_board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_repository.dart';
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
  Future<List<Board?>> getBoardsByCompanyID({
    required CompanyID companyID,
  });

  /// Emits a list of boards, if any, pertaining to the company specified with
  /// [CompanyID]
  Stream<List<Board?>> watchBoardsByCompanyID({
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
Stream<List<Board?>> boardListStream(BoardListStreamRef ref) {
  final boardRepository = ref.read(boardRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return const Stream.empty();
  return boardRepository.watchBoardsByCompanyID(companyID: companyId);
}

@riverpod
Future<List<Board?>> boardListFuture(BoardListFutureRef ref) {
  final boardRepository = ref.read(boardRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return Future.value([]);
  return boardRepository.getBoardsByCompanyID(companyID: companyId);
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

/// Keeps track of the id of the collector that is connected to
/// a [Board], it will have a value when user is updating
final collectorConnectedToBoardProvider = StateProvider<String?>((ref) {
  return null;
});

/// Keeps track of the id of the collector that user wants to connect
/// to a [Board]
final selectedCollectorIdProvider = StateProvider<String?>((ref) {
  return null;
});

/// gets a list of all collectors that are not yet connected
/// to a [Board]
@riverpod
Stream<List<Collector?>> collectorsNotConnectedToABoardStream(
    CollectorsNotConnectedToABoardStreamRef ref) {
  // Get a list of all collectors pertaining to a company
  final collectorsPertainingToACompany =
      ref.watch(collectorListStreamProvider).valueOrNull;

  if (collectorsPertainingToACompany == null) return Stream.value([]);
  final collectorIdToOmit = ref.watch(collectorConnectedToBoardProvider);

  // get a list of all available [Board]s and filter out their connected
  // collector ids. This is so because we're assuming that each available
  // [Board] has a collector connected to it.
  // The collector id of the collector connected to a board is omitted in this phase
  final connectedCollectorIds = ref
      .watch(boardListStreamProvider)
      .valueOrNull
      ?.where((board) => board?.collectorId != collectorIdToOmit)
      .map((board) => board?.collectorId)
      .toList() ?? [];

final collectorsNotConnectedToABoard = collectorsPertainingToACompany
      .where((collector) => !connectedCollectorIds.contains(collector?.id))
      .toList();

  return Stream.value(collectorsNotConnectedToABoard);
}
