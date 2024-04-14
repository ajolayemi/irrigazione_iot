// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user_database_keys.dart';

class CompanyUser extends Equatable {
  const CompanyUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  CompanyUser.empty()
      : id = '',
        email = '',
        fullName = '',
        role = CompanyUserRoles.user,
        companyId = '',
        createdAt = DateTime.parse('2024-01-01'),
        updatedAt = DateTime.parse('2024-01-01');

  final String id;
  final String email;
  final String fullName;
  final CompanyUserRoles role;
  final String companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object> get props {
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

  Map<String, dynamic> toMap() {
    return {
      CompanyUserDatabaseKeys.id: id,
      CompanyUserDatabaseKeys.email: email,
      CompanyUserDatabaseKeys.fullName: fullName,
      CompanyUserDatabaseKeys.role: role.name,
      CompanyUserDatabaseKeys.companyId: companyId,
      CompanyUserDatabaseKeys.createdAt: createdAt.toIso8601String(),
      CompanyUserDatabaseKeys.updatedAt: updatedAt.toIso8601String(),
    };
  }

  static CompanyUser fromMap(Map<String, dynamic> map) {
    return CompanyUser(
      id: map[CompanyUserDatabaseKeys.id] as String,
      email: map[CompanyUserDatabaseKeys.email] as String,
      fullName: map[CompanyUserDatabaseKeys.fullName] as String,
      role: map[CompanyUserDatabaseKeys.role].toString().toCompanyUserRoles(),
      companyId: map[CompanyUserDatabaseKeys.companyId] as String,
      createdAt:
          DateTime.parse(map[CompanyUserDatabaseKeys.createdAt] as String),
      updatedAt:
          DateTime.parse(map[CompanyUserDatabaseKeys.updatedAt] as String),
    );
  }
}
