import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'add_update_board_service.g.dart';


class AddUpdateBoardService {
  const AddUpdateBoardService(
    this._ref,
  );
  final Ref _ref;

  Future<void> createBoard(Board board) async {}

  Future<void> updateBoard(Board board) async {}
}


@riverpod
AddUpdateBoardService addUpdateBoardService (AddUpdateBoardServiceRef ref) {
  return AddUpdateBoardService(ref);
}