import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/shared/models/history_query_params.dart';
import 'package:irrigazione_iot/src/shared/models/path_params.dart';
import 'package:irrigazione_iot/src/shared/models/query_params.dart';

extension GoRouterStateX on GoRouterState {
  /// Gets the path parameters as a [PathParameters] object.
  PathParameters get toPathParams => PathParameters.fromJson(
        pathParameters,
      );

  /// Gets the "id" parameter from the path parameters.
  String get pathId => toPathParams.id;

  /// Gets the query parameters as a [QueryParameters] object.
  QueryParameters get toQueryParams => QueryParameters.fromJson(
        uri.queryParameters,
      );

  /// Gets the "id" parameter from the query parameters.
  String? get queryId => toQueryParams.id;

  /// Gets the "name" parameter from the query parameters.
  String? get queryName => toQueryParams.name;

  /// Gets the "previouslyConnectedId" parameter from the query parameters.
  String? get queryPreviouslyConnectedId => toQueryParams.previouslyConnectedId;

  /// Gets the history query parameters as a [HistoryQueryParameters] object.
  HistoryQueryParameters get toHistoryQueryParams =>
      HistoryQueryParameters.fromJson(uri.queryParameters);

  /// Gets the "columnName" parameter from the history query parameters.
  String get historyQueryColName => toHistoryQueryParams.columnName;

  /// Gets the "statisticName" parameter from the history query parameters.
  String get historyQueryStatisticName => toHistoryQueryParams.statisticName;
}
