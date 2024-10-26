import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board_database_keys.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/shared/models/rpc_parameter.dart';
import 'package:irrigazione_iot/src/utils/extensions/supabase_extensions.dart';

class SupabaseBoardRepository implements BoardRepository {
  SupabaseBoardRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<Board>? _boardsFromJsonList(List<Map<String, dynamic>>? data) {
    if (data == null) return [];
    return data.map((board) => Board.fromJson(board)).toList();
  }

  Board? _toBoard(Map<String, dynamic>? data) {
    return data == null ? null : Board.fromJson(data);
  }

  @override
  Future<Board?> createBoard({required Board board}) async {
    // set created_at and updated_at fields
    final data = board
        .copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
        .toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'insert-board',
      body: InsertBody(data: data).toJson(),
    );

    return res.toObject<Board>(Board.fromJson);
  }

  @override
  Future<Board?> updateBoard({required Board board}) async {
    final data = board.copyWith(updatedAt: DateTime.now()).toJson();
    final res = await _supabaseClient.invokeFunction(
      functionName: 'update-board',
      body: UpdateBody(
        id: board.id,
        data: data,
      ).toJson(),
    );

    return res.toObject<Board>(Board.fromJson);
  }

  @override
  Future<bool> deleteBoard({required String boardID}) async {
    final res = await _supabaseClient.invokeFunction(
      functionName: 'delete-boards',
      body: DeleteBody(ids: [boardID]).toJson(),
    );

    return res.onDelete;
  }

  @override
  Future<List<Collector>?> getAvailableCollectors({
    required String companyId,
    String? alreadyConnectedCollectorId,
  }) async {
    final rpcParam = RpcParameters(
      companyId: companyId,
      idAlreadyConnected: alreadyConnectedCollectorId?.isEmpty ?? false
          ? null
          : alreadyConnectedCollectorId,
    ).toJson();

    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(
            'get_collectors_not_connected_to_a_board',
            params: rpcParam)
        .withConverter((collectors) {
      if (collectors.isEmpty) return null;
      return collectors
          .map((collector) => Collector.fromJson(collector))
          .toList();
    });
  }

  @override
  Future<Board?> getBoard({required String boardId}) async {
    final data = await _supabaseClient.boards
        .select()
        .eq(BoardDatabaseKeys.id, boardId)
        .maybeSingle()
        .withConverter(_toBoard);

    return data;
  }

  @override
  Future<Board?> getBoardByCollectorId({required String collectorId}) async {
    final data = await _supabaseClient.boards
        .select()
        .eq(BoardDatabaseKeys.collectorId, collectorId)
        .limit(1)
        .maybeSingle()
        .withConverter(_toBoard);

    return data;
  }

  @override
  Future<List<Board>?> getBoardsByCompanyId({required String companyId}) async {
    final query = await _supabaseClient.boards
        .select()
        .eq(BoardDatabaseKeys.companyId, companyId);

    return _boardsFromJsonList(query);
  }

  @override
  Future<List<String>?> getUsedBoardNames({required String companyId}) async {
    final boards = await getBoardsByCompanyId(companyId: companyId);
    return boards?.map((board) => board.name.toLowerCase()).toList();
  }
}
