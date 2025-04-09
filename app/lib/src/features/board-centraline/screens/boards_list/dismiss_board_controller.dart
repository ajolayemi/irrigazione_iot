import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/utils/provider_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_board_controller.g.dart';

@riverpod
class DismissBoardController extends _$DismissBoardController {
  @override
  FutureOr<void> build() {}

  Future<bool> confirmDismiss(Board board) async {
    final boardRepo = ref.read(boardRepositoryProvider);
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(() => boardRepo.deleteBoard(boardID: board.id));

    final hasError = state.hasError;

    if (!hasError) {
      ProviderUtils.invalidateBoardStates(ref: ref, board: board);
    }
    return !state.hasError;
  }
}
