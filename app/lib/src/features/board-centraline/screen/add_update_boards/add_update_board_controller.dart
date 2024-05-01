import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/board-centraline/service/add_update_board_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_board_controller.g.dart';

@riverpod
class AddUpdateBoardController extends _$AddUpdateBoardController {
  @override
  FutureOr<void> build() {}

  Future<bool> createBoard({
    Board? boardToCreate,
    String? collectorIdToConnect,
  }) async {
    final boardService = ref.read(addUpdateBoardServiceProvider);
    state = const AsyncLoading();
    if (boardToCreate == null) {
      state = AsyncError(
        'no board object provided for creation',
        StackTrace.current,
      );
      return Future.value(false);
    }

    if (collectorIdToConnect == null) {
      state = AsyncError(
        'no collector id provided for connection',
        StackTrace.current,
      );
      return Future.value(false);
    }

    state = await AsyncValue.guard(
      () => boardService.createBoard(
        board: boardToCreate,
        collectorIdToConnect: collectorIdToConnect,
      ),
    );
    return !state.hasError;
  }

  Future<bool> updateBoard({
   Board? boardToUpdate,
    String? collectorIdToConnect,
  }) async {
    final boardService = ref.read(addUpdateBoardServiceProvider);
    state = const AsyncLoading();
    if (boardToUpdate == null) {
      state = AsyncError(
        'no board object provided for update',
        StackTrace.current,
      );
      return false;
    }

    if (collectorIdToConnect == null) {
      state = AsyncError(
        'no collector id provided for connection',
        StackTrace.current,
      );
      return false;
    }

    state = await AsyncValue.guard(
      () => boardService.updateBoard(
        board: boardToUpdate,
        collectorIdToConnect: collectorIdToConnect,
      ),
    );
    return !state.hasError;
  }
}
