import 'package:irrigazione_iot/src/features/board-centraline/models/board_database_keys.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/shared/models/db_cud_bodies.dart';
import 'package:irrigazione_iot/src/shared/models/rpc_parameter.dart';
import 'package:irrigazione_iot/src/utils/supabase_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';

class SupabaseBoardRepository implements BoardRepository {
  SupabaseBoardRepository(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  List<Board?> _boardsFromJsonList(List<Map<String, dynamic>>? data) {
    if (data == null) return [];
    return data.map((board) => Board.fromJson(board)).toList();
  }

  Board? _boardFromJsonSingle(List<Map<String, dynamic>> data) {
    return data.isEmpty ? null : Board.fromJson(data.first);
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
      functionName: 'delete-board',
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
  Stream<Board?> watchBoardByBoardID({required String boardID}) {
    final stream =
        _supabaseClient.boardStream.eq(BoardDatabaseKeys.id, boardID).limit(1);

    return stream.map(_boardFromJsonSingle);
  }

  @override
  Stream<Board?> watchBoardByCollectorID({required String collectorID}) {
    final stream = _supabaseClient.boardStream
        .eq(BoardDatabaseKeys.collectorId, collectorID)
        .limit(1);

    return stream.map(_boardFromJsonSingle);
  }

  @override
  Stream<List<Board?>> watchBoardsByCompanyID({required String companyID}) {
    final stream = _supabaseClient.boardStream.eq(
      BoardDatabaseKeys.companyId,
      companyID,
    );

    return stream.map(_boardsFromJsonList);
  }

  @override
  Stream<List<String?>> watchCompanyUsedBoardNames(String companyId) {
    return watchBoardsByCompanyID(companyID: companyId).map(
      (boards) => boards.map((board) => board?.name.toLowerCase()).toList(),
    );
  }

  @override
  Stream<List<String?>> watchBoardsUsedMqttNames() {
    return _supabaseClient.boards
        .stream(primaryKey: [BoardDatabaseKeys.id]).map(
      (boards) => boards
          .map(
            (board) => Board.fromJson(board).mqttMsgName.toLowerCase(),
          )
          .toList(),
    );
  }
}
