import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/service/add_update_board_service.dart';

part 'add_update_board_controller.g.dart';

@riverpod
class AddUpdateBoardController extends _$AddUpdateBoardController {
  @override
  FutureOr<void> build() {

  }

  Future<bool> createBoard({required Board? boardToCreate}) async {
    final boardService = ref.read(addUpdateBoardServiceProvider);
    state = const AsyncLoading();
    if (boardToCreate == null) {
      state = AsyncError(
        'no board object provided for creation',
        StackTrace.current,
      );
      return Future.value(false);
    }
    state = await AsyncValue.guard(
        () => boardService.createBoard(boardToCreate));
    return !state.hasError;
  }

  Future<bool> updateBoard({required Board? boardToUpdate}) async {
    final boardService = ref.read(addUpdateBoardServiceProvider);
    state = const AsyncLoading();
    if (boardToUpdate == null) {
      state = AsyncError(
        'no board object provided for update',
        StackTrace.current,
      );
      return false;
    }

    state = await AsyncValue.guard(
        () => boardService.updateBoard(boardToUpdate));
    return !state.hasError;
  }
}