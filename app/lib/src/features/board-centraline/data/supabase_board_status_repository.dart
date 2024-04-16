import 'package:irrigazione_iot/src/features/board-centraline/data/board_status_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_status.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBoardStatusRepository implements BoardStatusRepository {
  const SupabaseBoardStatusRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<BoardStatus?> getBoardStatus(String boardID) {
    // TODO: implement getBoardStatus
    throw UnimplementedError();
  }

  @override
  Stream<BoardStatus?> watchBoardStatus(String boardID) {
    // TODO: implement watchBoardStatus
    throw UnimplementedError();
  }

  
}
