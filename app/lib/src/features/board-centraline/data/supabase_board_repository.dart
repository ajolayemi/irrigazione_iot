import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';

class SupabaseBoardRepository implements BoardRepository {
  SupabaseBoardRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<Board?> createBoard({required Board board}) {
    // TODO: implement addBoard
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteBoard({required String boardID}) {
    // TODO: implement deleteBoard
    throw UnimplementedError();
  }

  @override
  Future<Board?> updateBoard({required Board board}) {
    // TODO: implement updateBoard
    throw UnimplementedError();
  }

  @override
  Stream<Board?> watchBoardByBoardID({required String boardID}) {
    // TODO: implement watchBoardByBoardID
    throw UnimplementedError();
  }

  @override
  Stream<Board?> watchBoardByCollectorID({required String collectorID}) {
    // TODO: implement watchBoardByCollectorID
    throw UnimplementedError();
  }

  @override
  Stream<List<Board?>> watchBoardsByCompanyID({required String companyID}) {
    // TODO: implement watchBoardsByCompanyID
    throw UnimplementedError();
  }
}
