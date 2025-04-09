// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  /// [companyId]
  Future<List<Board>?> getBoardsByCompanyId({required String companyId});

  /// Returns the [Board] associated with a collector specified by collectorId
  Future<Board?> getBoardByCollectorId({required String collectorId});

  /// Fetches the [Board] associated with the provided [boardId]
  Future<Board?> getBoard({required String boardId});

  /// Add a new [Board] to the database and returns the newly added [Board] if successful
  Future<Board?> createBoard({required Board board});

  /// Update an existing [Board] in the database and returns the updated [Board] if successful
  Future<Board?> updateBoard({required Board board});

  /// Delete a [Board] from the database and returns true if successful
  Future<bool> deleteBoard({required String boardID});

  /// Gets a list of all [Collector]s that are not yet connected to a [Board]
  /// This is used when a user wants to connect a collector to a board
  Future<List<Collector>?> getAvailableCollectors({
    required String companyId,
    String? alreadyConnectedCollectorId,
  });

  /// Returns a list of already used board names for a specified company
  /// this is used in form validation to prevent duplicate board names for a company
  Future<List<String>?> getUsedBoardNames({required String companyId});
}

@Riverpod(keepAlive: true)
BoardRepository boardRepository(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseBoardRepository(supabaseClient);
}

@riverpod
FutureOr<List<Board>?> boardsList(Ref ref) {
  final companyId = ref.watch(tappedCompanyIdProvider).valueOrNull;
  if (companyId == null) return Future.value([]);
  final repo = ref.watch(boardRepositoryProvider);
  return repo.getBoardsByCompanyId(companyId: companyId);
}

@riverpod
FutureOr<Board?> collectorBoard(
  Ref ref, {
  required String collectorId,
}) {
  final repo = ref.watch(boardRepositoryProvider);
  return repo.getBoardByCollectorId(collectorId: collectorId);
}

@Riverpod(keepAlive: true)
Future<Board?> board(
  Ref ref, {
  required String boardId,
}) {
  final boardRepository = ref.watch(boardRepositoryProvider);
  return boardRepository.getBoard(boardId: boardId);
}

/// gets a list of all collectors that are not yet connected
/// to a [Board]
@riverpod
Future<List<Collector>?> availableCollectorsFuture(
  Ref ref, {
  String? alreadyConnectedCollectorId,
}) {
  final currentSelectedCompany =
      ref.watch(currentTappedCompanyProvider).valueOrNull;
  if (currentSelectedCompany == null) return Future.value([]);
  final boardRepository = ref.watch(boardRepositoryProvider);
  return boardRepository.getAvailableCollectors(
    companyId: currentSelectedCompany.id,
    alreadyConnectedCollectorId: alreadyConnectedCollectorId,
  );
}

@Riverpod(keepAlive: true)
FutureOr<List<String>?> usedBoardNames(Ref ref) {
  final boardRepository = ref.watch(boardRepositoryProvider);
  final companyId = ref.watch(tappedCompanyIdProvider).valueOrNull;
  if (companyId == null) return Future.value([]);
  return boardRepository.getUsedBoardNames(companyId: companyId);
}
