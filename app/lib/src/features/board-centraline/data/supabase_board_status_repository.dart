import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status_database_keys.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBoardStatusRepository implements BoardStatusRepository {
  const SupabaseBoardStatusRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<BoardStatus?> getBoardStatus(String boardID) async {
    final status =
        await _supabaseClient.boardStatus
            .select()
            .eq(BoardStatusDatabaseKeys.boardId, boardID)
            .order(BoardStatusDatabaseKeys.createdAt, ascending: false)
            .limit(1)
            .maybeSingle();

    if (status == null) return null;

    return BoardStatus.fromJson(status);
  }
}
