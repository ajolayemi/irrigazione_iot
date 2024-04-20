import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_update_board_service.g.dart';

class AddUpdateBoardService {
  const AddUpdateBoardService(
    this._ref,
  );
  final Ref _ref;

  Future<void> createBoard(Board board) async {
    // the board argument that is provided as argument has no company
    // id, so we need to get it from somewhere else

    final user = _ref.read(authRepositoryProvider).currentUser;

    // If user is null, that shouldn't be the case but just to be sure
    if (user == null) {
      debugPrint('Exiting createBoard, user is null');
      return;
    }

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    // Just in case no company id is found
    if (companyId == null) {
      debugPrint('Exiting createBoard, companyId is null');
      return;
    }

    // reference the state provider that tracks what collector user chose
    // to connect to the board
    final selectedCollector = _ref.read(selectedCollectorProvider);

    // just in case non collector was selected, that shouldn't be the case though
    // because the form validation logic already checks for that
    if (selectedCollector == null) {
      debugPrint('Exiting createBoard, selectedCollector is null');
      return;
    }

    // Reaching here means all necessary checks have been passed
    final createdBoard = await _ref.read(boardRepositoryProvider).addBoard(
            board: board.copyWith(
          companyId: companyId,
          collectorId: selectedCollector.value,
        ));

    debugPrint('created board: ${createdBoard?.toJson()}');
  }

  Future<void> updateBoard(Board board) async {
    // The only check to perform here is to make sure that who reaches
    // here is a logged in user, that is so because an updated board
    // should have all the necessary information attached already from the form
    final user = _ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      debugPrint('Exiting updateBoard, user is null');
      return;
    }
    final updatedBoard = await _ref.read(boardRepositoryProvider).updateBoard(
          board: board,
        );

    debugPrint('updated board: ${updatedBoard?.toJson()}');
  }
}

@riverpod
AddUpdateBoardService addUpdateBoardService(AddUpdateBoardServiceRef ref) {
  return AddUpdateBoardService(ref);
}
