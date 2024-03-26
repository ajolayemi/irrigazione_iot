// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

typedef CompanyUserID = int;

// A representation of the relationship between a user and a company
class CompanyUser extends Equatable {
  const CompanyUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.companyId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  CompanyUser.empty()
      : id = 0,
        email = '',
        fullName = '',
        companyId = '',
        role = CompanyUserRoles.user,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  final CompanyUserID id;
  final String email;
  final String fullName;
  final CompanyID companyId;
  final CompanyUserRoles role;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      email,
      fullName,
      companyId,
      role,
      createdAt,
      updatedAt,
    ];
  }

  CompanyUser copyWith({
    CompanyUserID? id,
    String? email,
    String? fullName,
    CompanyID? companyId,
    CompanyUserRoles? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      companyId: companyId ?? this.companyId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullName': fullName,
      'companyId': companyId,
      'role': role.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CompanyUser.fromJson(Map<String, dynamic> map) {
    return CompanyUser(
      id: map['id'] as CompanyUserID,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      companyId: map['companyId'] as CompanyID,
      role: (map['role'] as String).toCompanyUserRoles,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }
}
