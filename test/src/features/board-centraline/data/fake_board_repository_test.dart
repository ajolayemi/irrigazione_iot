import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irrigazione_iot/src/config/mock/fake_boards.dart';
import 'package:irrigazione_iot/src/features/board-centraline/data/fake_board_repository.dart';

void main() {
  const testBoardId = '1';

  /// The expected result when fetching a board by its id in this test
  final expectedBoardByBoardId = kFakeBoards.first;
  const testCompanyId = '1';

  /// The expected result when fetching a board by companyId in this test
  final expectedBoardByCompanyId =
      kFakeBoards.where((board) => board.companyId == testCompanyId).toList();
  const testCollectorId = '1';

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
  });
}
