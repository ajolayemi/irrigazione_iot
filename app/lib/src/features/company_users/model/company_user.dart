import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user_database_keys.dart';

part 'company_user.g.dart';

@JsonSerializable()
class CompanyUser extends Equatable {
  const CompanyUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.companyId,
    this.createdAt,
    this.updatedAt,
  });

  const CompanyUser.empty()
      : id = '',
        email = '',
        fullName = '',
        role = CompanyUserRoles.user,
        companyId = '',
        createdAt = null,
        updatedAt = null;

  @JsonKey(name: CompanyUserDatabaseKeys.id)
  final String id;
  @JsonKey(name: CompanyUserDatabaseKeys.email)
  final String email;
  @JsonKey(name: CompanyUserDatabaseKeys.fullName)
  final String fullName;
  @JsonKey(name: CompanyUserDatabaseKeys.role)
  final CompanyUserRoles role;
  @JsonKey(name: CompanyUserDatabaseKeys.companyId)
  final String companyId;
  @JsonKey(name: CompanyUserDatabaseKeys.createdAt)
  final DateTime? createdAt;
  @JsonKey(name: CompanyUserDatabaseKeys.updatedAt)
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      email,
      fullName,
      role,
      companyId,
      createdAt,
      updatedAt,
    ];
  }

  CompanyUser copyWith({
    String? id,
    String? email,
    String? fullName,
    CompanyUserRoles? role,
    String? companyId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CompanyUser.fromJson(Map<String, dynamic> json) =>
      _$CompanyUserFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyUserToJson(this);
}
