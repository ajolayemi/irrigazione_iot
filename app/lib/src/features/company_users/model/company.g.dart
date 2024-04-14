// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: json['id'] as String,
      name: json['name'] as String,
      registeredOfficeAddress: json['registered_office_address'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      imageUrl: json['image_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      vatNumber: json['piva'] as String? ?? '',
      fiscalCode: json['cf'] as String? ?? '',
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'registered_office_address': instance.registeredOfficeAddress,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'piva': instance.vatNumber,
      'cf': instance.fiscalCode,
    };
