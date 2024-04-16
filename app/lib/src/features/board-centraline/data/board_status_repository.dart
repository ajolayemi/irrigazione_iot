import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/board-centraline/data/supabase_board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'board_status_repository.g.dart';

abstract class BoardStatusRepository {
  /// Fetches the most recent [BoardStatus] for the provided boardId
  Future<BoardStatus?> getBoardStatus(String boardID);

  /// Emits the most recent [BoardStatus] for the provided boardId
  Stream<BoardStatus?> watchBoardStatus(String boardID);
}

@Riverpod(keepAlive: true)
BoardStatusRepository boardStatusRepository(BoardStatusRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseBoardStatusRepository(supabaseClient);
}

@riverpod
Stream<BoardStatus?> boardStatusStream(BoardStatusStreamRef ref,
    {required String boardID}) {
  final boardStatusRepository = ref.read(boardStatusRepositoryProvider);
  return boardStatusRepository.watchBoardStatus(boardID);
}

@riverpod
Future<BoardStatus?> boardStatusFuture(BoardStatusFutureRef ref,
    {required String boardID}) {
  final boardStatusRepository = ref.read(boardStatusRepositoryProvider);
  return boardStatusRepository.getBoardStatus(boardID);
}
