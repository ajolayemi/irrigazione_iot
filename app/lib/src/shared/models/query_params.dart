import 'package:json_annotation/json_annotation.dart';

part 'query_params.g.dart';

@JsonSerializable()
class QueryParameters {
  const QueryParameters({
    this.id,
    this.name,
  });

  /// Could be the id of a pump, a specie, a sector, etc.
  final String? id;

  /// Could be the name of a pump, a specie, a sector, etc.
  final String? name;

  factory QueryParameters.fromJson(Map<String, dynamic> json) =>
      _$QueryParametersFromJson(json);

  Map<String, dynamic> toJson() => _$QueryParametersToJson(this);
}
