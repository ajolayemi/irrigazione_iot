import 'package:irrigazione_iot/src/features/board-centraline/data/board_repository.dart';
import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';

class FakeBoardRepository implements BoardRepository {
  @override
  Future<Board?> addBoard({required Board board}) {
    // TODO: implement addBoard
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteBoard({required BoardID boardID}) {
    // TODO: implement deleteBoard
    throw UnimplementedError();
  }

  @override
  Future<List<Board>?> geBoardsByCompanyID({required CompanyID companyID}) {
    // TODO: implement geBoardsByCompanyID
    throw UnimplementedError();
  }

  @override
  Future<Board?> getBoardByCollectorID({required CollectorID collectorID}) {
    // TODO: implement getBoardByCollectorID
    throw UnimplementedError();
  }

  @override
  Stream<Board?> streamBoardByCollectorID({required CollectorID collectorID}) {
    // TODO: implement streamBoardByCollectorID
    throw UnimplementedError();
  }

  @override
  Stream<List<Board>?> streamBoardsByCompanyID({required CompanyID companyID}) {
    // TODO: implement streamBoardsByCompanyID
    throw UnimplementedError();
  }

  @override
  Future<Board?> updateBoard({required Board board}) {
    // TODO: implement updateBoard
    throw UnimplementedError();
  }

}