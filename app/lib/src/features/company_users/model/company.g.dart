// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: const IntConverter().fromJson(json['id'] as int),
      name: json['name'] as String,
      registeredOfficeAddress: json['registered_office_address'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      imageUrl: json['image_url'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      vatNumber: json['piva'] as String? ?? '',
      fiscalCode: json['cf'] as String? ?? '',
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'name': instance.name,
      'registered_office_address': instance.registeredOfficeAddress,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'piva': instance.vatNumber,
      'cf': instance.fiscalCode,
    };
