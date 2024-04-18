// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_cud_bodies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertBody _$InsertBodyFromJson(Map<String, dynamic> json) => InsertBody(
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$InsertBodyToJson(InsertBody instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UpdateBody _$UpdateBodyFromJson(Map<String, dynamic> json) => UpdateBody(
      id: json['id'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UpdateBodyToJson(UpdateBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
    };

DeleteBody _$DeleteBodyFromJson(Map<String, dynamic> json) => DeleteBody(
      ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DeleteBodyToJson(DeleteBody instance) =>
    <String, dynamic>{
      'ids': instance.ids,
    };
