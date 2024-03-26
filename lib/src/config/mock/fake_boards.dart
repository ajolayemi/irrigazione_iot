import 'package:irrigazione_iot/src/config/mock/fake_collectors.dart';
import 'package:irrigazione_iot/src/config/mock/fake_companies_list.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';

List<Board> _generateFakeBoards() {
  List<Board> boards = [];
  int boardId = 1;
  for (final company in kFakeCompanies) {
    final companyCollectors = kFakeCollectors.where(
      (collector) => collector.companyId == company.id,
    );
    if (companyCollectors.isEmpty) continue;

    for (final collector in companyCollectors) {
      boards.add(
        Board(
          id: boardId.toString(),
          name: 'arduino ${collector.name}',
          model: 'mkr4',
          serialNumber: '123456',
          collectorId: collector.id,
          companyId: company.id,
        ),
      );
      boardId++;
    }
  }
  return boards;
}

final kFakeBoards = _generateFakeBoards();
