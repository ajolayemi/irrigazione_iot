import 'dart:async';

import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/board-centraline/data/supabase_board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'board_status_repository.g.dart';

abstract class BoardStatusRepository {
  /// Gets the most recent [BoardStatus] for the provided boardId
  Future<BoardStatus?> getBoardStatus(String boardID);
}

@Riverpod(keepAlive: true)
BoardStatusRepository boardStatusRepository(BoardStatusRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseBoardStatusRepository(supabaseClient);
}


/// Holds onto the most recent [BoardStatus] for a board
/// It auto updates at a set interval
@Riverpod(keepAlive: true)
FutureOr<BoardStatus?> boardStatus(
  BoardStatusRef ref, {
  required String boardId,
}) {
  final timer = Timer.periodic(AppConstants.boardStatusUpdateInterval, (_) {
    ref.invalidateSelf();
  });

  ref.onDispose(() {
    timer.cancel();
  });

  final repo = ref.watch(boardStatusRepositoryProvider);
  return repo.getBoardStatus(boardId);
}
