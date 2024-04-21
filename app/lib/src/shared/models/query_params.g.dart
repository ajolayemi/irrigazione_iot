// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryParameters _$QueryParametersFromJson(Map<String, dynamic> json) =>
    QueryParameters(
      id: json['id'] as String?,
      name: json['name'] as String?,
      previouslyConnectedId: json['previouslyConnectedId'] as String?,
    );

Map<String, dynamic> _$QueryParametersToJson(QueryParameters instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'previouslyConnectedId': instance.previouslyConnectedId,
    };
