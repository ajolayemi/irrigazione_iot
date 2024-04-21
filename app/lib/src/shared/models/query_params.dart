import 'package:json_annotation/json_annotation.dart';

part 'query_params.g.dart';

@JsonSerializable()
class QueryParameters {
  const QueryParameters({
    this.id,
    this.name,
    this.previouslyConnectedId,
  });

  /// Could be the id of a pump, a specie, a sector, etc.
  final String? id;

  /// Could be the name of a pump, a specie, a sector, etc.
  final String? name;

  /// When updating entities like sectors, pumps, etc., it is expected
  /// that a pump was previously connected to a sector.
  /// This keeps track of that
  final String? previouslyConnectedId;

  factory QueryParameters.fromJson(Map<String, dynamic> json) =>
      _$QueryParametersFromJson(json);

  Map<String, dynamic> toJson() => _$QueryParametersToJson(this);
}
