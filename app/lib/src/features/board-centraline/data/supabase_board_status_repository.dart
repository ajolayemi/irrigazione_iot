import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBoardStatusRepository implements BoardStatusRepository {
  const SupabaseBoardStatusRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Stream<BoardStatus?> watchBoardStatus(String boardID) {
    final stream = _supabaseClient.boardStatus
        .stream(primaryKey: [BoardStatusDatabaseKeys.id])
        .eq(BoardStatusDatabaseKeys.boardId, boardID)
        .order(BoardStatusDatabaseKeys.createdAt, ascending: false)
        .limit(1);

    return stream.map((statuses) {
      if (statuses.isEmpty) return null;
      return BoardStatus.fromJson(statuses.first);
    });
  }

  
}
