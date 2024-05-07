import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/board-centraline/data/supabase_board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'board_repository.g.dart';

/// A [Board] is "centraline" in italian and refers to the arduino boards
/// that are connected to the server (mainly nodered)
/// This repository is responsible for managing the boards.
abstract class BoardRepository {
  /// Emits a list of boards, if any, pertaining to the company specified with
  /// [String]
  Stream<List<Board?>> watchBoardsByCompanyID({
    required String companyID,
  });

  /// Emits the [Board] associated with a collector specified by collectorId
  Stream<Board?> watchBoardByCollectorID({
    required String collectorID,
  });

  /// Emits the [Board] associated with the provided boardId
  Stream<Board?> watchBoardByBoardID({
    required String boardID,
  });

  /// Add a new [Board] to the database and returns the newly added [Board] if successful
  Future<Board?> createBoard({
    required Board board,
  });

  /// Update an existing [Board] in the database and returns the updated [Board] if successful
  Future<Board?> updateBoard({
    required Board board,
  });

  /// Delete a [Board] from the database and returns true if successful
  Future<bool> deleteBoard({
    required String boardID,
  });

  /// Gets a list of all [Collector]s that are not yet connected to a [Board]
  /// This is used when a user wants to connect a collector to a board
  Future<List<Collector>?> getAvailableCollectors({
    required String companyId,
    String? alreadyConnectedCollectorId,
  });

  /// Emits a list of already used board names for a specified company
  /// this is used in form validation to prevent duplicate board names for a company
  Stream<List<String?>> watchCompanyUsedBoardNames(String companyId);

  /// Emits a list of already used mqtt names in general
  /// this is used in form validation to prevent duplicate mqtt names
  /// for boards
  Stream<List<String?>> watchBoardsUsedMqttNames();
}

@Riverpod(keepAlive: true)
BoardRepository boardRepository(BoardRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseBoardRepository(supabaseClient);
}

@riverpod
Stream<List<Board?>> boardListStream(BoardListStreamRef ref) {
  final boardRepository = ref.read(boardRepositoryProvider);
  final companyId = ref.watch(currentTappedCompanyProvider).valueOrNull?.id;
  if (companyId == null) return const Stream.empty();
  return boardRepository.watchBoardsByCompanyID(companyID: companyId);
}

@riverpod
Stream<Board?> collectorBoardStream(CollectorBoardStreamRef ref,
    {required String collectorID}) {
  final boardRepository = ref.read(boardRepositoryProvider);
  return boardRepository.watchBoardByCollectorID(collectorID: collectorID);
}

@riverpod
Stream<Board?> boardStream(BoardStreamRef ref, {required String boardID}) {
  final boardRepository = ref.watch(boardRepositoryProvider);
  return boardRepository.watchBoardByBoardID(boardID: boardID);
}


/// gets a list of all collectors that are not yet connected
/// to a [Board]
@riverpod
Future<List<Collector>?> availableCollectorsFuture(
    AvailableCollectorsFutureRef ref,
    {String? alreadyConnectedCollectorId}) {
  final currentSelectedCompany =
      ref.watch(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompany == null) return Future.value([]);
  final boardRepository = ref.watch(boardRepositoryProvider);
  return boardRepository.getAvailableCollectors(
      companyId: currentSelectedCompany.id,
      alreadyConnectedCollectorId: alreadyConnectedCollectorId);
}

@riverpod
Stream<List<String?>> usedBoardNamesStream(UsedBoardNamesStreamRef ref) {
  final boardRepository = ref.watch(boardRepositoryProvider);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompanyByUser == null) return const Stream.empty();
  return boardRepository
      .watchCompanyUsedBoardNames(currentSelectedCompanyByUser.id);
}

@riverpod
Stream<List<String?>> boardsUsedMqttNamesStream(BoardsUsedMqttNamesStreamRef ref) {
  final boardRepository = ref.watch(boardRepositoryProvider);
  return boardRepository.watchBoardsUsedMqttNames();
}
