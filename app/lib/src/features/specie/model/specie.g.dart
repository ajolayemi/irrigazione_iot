// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specie _$SpecieFromJson(Map<String, dynamic> json) => Specie(
      id: const IntConverter().fromJson(json['id'] as int),
      name: json['name'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SpecieToJson(Specie instance) => <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'name': instance.name,
      'created_at': instance.createdAt?.toIso8601String(),
    };
