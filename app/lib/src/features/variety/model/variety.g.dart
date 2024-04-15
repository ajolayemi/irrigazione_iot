// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variety.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variety _$VarietyFromJson(Map<String, dynamic> json) => Variety(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$VarietyToJson(Variety instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt?.toIso8601String(),
    };
