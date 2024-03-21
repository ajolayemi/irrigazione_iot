import 'package:irrigazione_iot/src/features/board-centraline/models/board.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company.dart';

/// A [Board] is "centraline" in italian and refers to the arduino boards 
/// that are connected to the server (mainly nodered)
/// This repository is responsible for managing the boards.
abstract class BoardRepository {

  /// Fetches a list of boards, if any, pertaining to the company specified with
  /// [CompanyID]
  Future<List<Board>?> geBoardsByCompanyID({
    required CompanyID companyID,
  });

  /// Emits a list of boards, if any, pertaining to the company specified with
  /// [CompanyID]
  Stream<List<Board>?> streamBoardsByCompanyID({
    required CompanyID companyID,
  });

  /// Fetches the [Board] associated with a collector specified by [CollectorID]
  Future<Board?> getBoardByCollectorID({
    required CollectorID collectorID,
  });

  /// Emits the [Board] associated with a collector specified by [CollectorID]
  Stream<Board?> streamBoardByCollectorID({
    required CollectorID collectorID,
  });

  /// Add a new [Board] to the database and returns the newly added [Board] if successful
  Future<Board?> addBoard({
    required Board board,
  });

  /// Update an existing [Board] in the database and returns the updated [Board] if successful
  Future<Board?> updateBoard({
    required Board board,
  });

  /// Delete a [Board] from the database and returns true if successful
  Future<bool> deleteBoard({
    required BoardID boardID,
  });
}