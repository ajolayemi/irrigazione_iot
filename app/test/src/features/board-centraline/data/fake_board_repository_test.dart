import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_boards.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/fake_board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';

void main() {
  const testBoardId = '1';

  /// The expected result when fetching a board by its id in this test
  final expectedBoardByBoardId = kFakeBoards.first;
  const testCompanyId = '1';

  /// The expected result when fetching a board by companyId in this test
  final expectedBoardByCompanyId =
      kFakeBoards.where((board) => board.companyId == testCompanyId).toList();

  const testCollectorId = '1';

  /// The expected result when fetching board by collectorId in this test
  final expectedBoardByCollectorId = kFakeBoards
      .firstWhereOrNull((board) => board.collectorId == testCollectorId);

  late FakeBoardRepository fakeBoardRepository;
  FakeBoardRepository makeFakeBoardRepository() {
    return FakeBoardRepository(addDelay: false);
  }

  setUpAll(() {
    debugPrint('setting up');
    fakeBoardRepository = makeFakeBoardRepository();
  });

  tearDownAll(() {
    debugPrint('tearing down');
    fakeBoardRepository.dispose();
  });

  group('FakeBoardRepository', () {
    group(' - getBoardByBoardID', () {
      test('called with 1 returns the expected value', () async {
        await expectLater(
          fakeBoardRepository.getBoardByBoardID(boardID: testBoardId),
          completion(expectedBoardByBoardId),
        );
      });

      test('called with 9000 returns null', () async {
        await expectLater(
          fakeBoardRepository.getBoardByBoardID(boardID: '9000'),
          completion(null),
        );
      });
    });

    group('- watchBoardByBoardID', () {
      test('called with 1 emits the expected board', () {
        expect(
          fakeBoardRepository.watchBoardByBoardID(boardID: testBoardId),
          emits(expectedBoardByBoardId),
        );
      });

      test('called with 9000 emits null', () {
        expect(
          fakeBoardRepository.watchBoardByBoardID(boardID: '9000'),
          emits(null),
        );
      });
    });

    group('- getBoardsByCompanyID', () {
      test('called with 1 returns the expect list of boards', () async {
        await expectLater(
            fakeBoardRepository.getBoardsByCompanyID(companyID: testCompanyId),
            completion(expectedBoardByCompanyId));
      });

      test('called with 9000 returns an empty list', () async {
        await expectLater(
            fakeBoardRepository.getBoardsByCompanyID(companyID: '9000'),
            completion(isEmpty));
      });
    });

    group('- watchBoardsByCompanyID', () {
      test('called with 1 emits the expected list of boards', () {
        expect(
            fakeBoardRepository.watchBoardsByCompanyID(
                companyID: testCompanyId),
            emits(expectedBoardByCompanyId));
      });

      test('called with 9000 emits an empty list', () {
        expect(fakeBoardRepository.watchBoardsByCompanyID(companyID: '9000'),
            emits(isEmpty));
      });
    });

    group('- getBoardByCollectorID', () {
      test('called with 1 returns the expected result', () async {
        await expectLater(
            fakeBoardRepository.getBoardByCollectorID(
                collectorID: testCollectorId),
            completion(expectedBoardByCollectorId));
      });

      test('called with 9000 returns null', () async {
        await expectLater(
            fakeBoardRepository.getBoardByCollectorID(collectorID: '9000'),
            completion(null));
      });
    });

    group('- watchBoardByCollectorID', () {
      test('called with 1 emits the expected result', () {
        expect(
            fakeBoardRepository.watchBoardByCollectorID(
                collectorID: testCollectorId),
            emits(expectedBoardByCollectorId));
      });

      test('called with 9000 emits null', () {
        expect(fakeBoardRepository.watchBoardByCollectorID(collectorID: '9000'),
            emits(null));
      });
    });

    group('- addBoard', () {
      test('adds a board to the list of boards', () async {
        final newBoard = kFakeBoards.first.copyWith(name: 'new board for test');
        final res = await fakeBoardRepository.addBoard(board: newBoard);

        // After creation is done
        // The returned board should be different
        expect(res, isNot(kFakeBoards.first));
        // It shouldn't be null
        expect(res, isNotNull);
        // It must be of type Board
        expect(res, isA<Board>());
      });
    });

    group('- updateBoard', () {
      test('updates a board in the list of boards returns the updated board',
          () async {
        final updatedBoard = kFakeBoards.first.copyWith(name: 'updated board');
        final res = await fakeBoardRepository.updateBoard(board: updatedBoard);

        // After update is done, the returned board
        // should be the same as the one passed as arg
        expect(res, updatedBoard);
        // should be different from the original 
        // board (just for double check)
        expect(res, isNot(kFakeBoards.first));
        // It shouldn't be null
        expect(res, isNotNull);
        // It must be of type Board
        expect(res, isA<Board>());
      });

      test('updating a non-existent board returns null', () async {
        const nonExistentBoardForTest = Board(
          id: '9000',
          name: 'non-existent board',
          companyId: '1',
          collectorId: '1',
          model: 'model',
          serialNumber: 'serialNumber',
        );

        final res = await fakeBoardRepository.updateBoard(
          board: nonExistentBoardForTest,
        );

        // null should be returned
        expect(res, isNull);
        // the returned result shouldn't be of type Board
        // just to double check
        expect(res, isNot(isA<Board>()));
      });
    });

    group('- deleteBoard', () {
      test('deletes a board from the list of boards', () async {
        final res = await fakeBoardRepository.deleteBoard(boardID: testBoardId);
        expect(res, isTrue);
      });

      test('deleting a non-existent board returns false', () async {
        const nonExistentBoardId = '9000';
        final res =
            await fakeBoardRepository.deleteBoard(boardID: nonExistentBoardId);
        expect(res, isFalse);
      });
    });
  });
}