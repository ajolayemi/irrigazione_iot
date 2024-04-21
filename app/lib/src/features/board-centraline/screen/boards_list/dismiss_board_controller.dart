import '../../data/board_repository.dart';
import '../../models/board.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dismiss_board_controller.g.dart';

@riverpod
class DismissBoardController extends _$DismissBoardController {
  @override
  FutureOr<void> build() {}


  Future<bool> confirmDismiss(BoardID boardId) async {
    final boardRepo = ref.read(boardRepositoryProvider);
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(
        () => boardRepo.deleteBoard(boardID: boardId));
    return !state.hasError;
  }
}
