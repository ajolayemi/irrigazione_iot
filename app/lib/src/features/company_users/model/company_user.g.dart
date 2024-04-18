// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyUser _$CompanyUserFromJson(Map<String, dynamic> json) => CompanyUser(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      role: $enumDecode(_$CompanyUserRolesEnumMap, json['role']),
      companyId: json['company_id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CompanyUserToJson(CompanyUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'full_name': instance.fullName,
      'role': _$CompanyUserRolesEnumMap[instance.role]!,
      'company_id': instance.companyId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$CompanyUserRolesEnumMap = {
  CompanyUserRoles.superuser: 'superuser',
  CompanyUserRoles.owner: 'owner',
  CompanyUserRoles.admin: 'admin',
  CompanyUserRoles.user: 'user',
};
