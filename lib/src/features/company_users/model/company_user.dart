// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

// A representation of the relationship between a user and a company
class CompanyUser extends Equatable {
  const CompanyUser({
    required this.email,
    required this.companyId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
  final String email;
  final CompanyID companyId;
  final CompanyUserRoles role;
  final DateTime createdAt;
  final DateTime updatedAt;


  @override
  List<Object> get props {
    return [
      email,
      companyId,
      role,
      createdAt,
      updatedAt,
    ];
  }

  CompanyUser copyWith({
    String? email,
    CompanyID? companyId,
    CompanyUserRoles? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyUser(
      email: email ?? this.email,
      companyId: companyId ?? this.companyId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'companyId': companyId,
      'role': role.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CompanyUser.fromJson(Map<String, dynamic> map) {
    return CompanyUser(
      email: map['email'] as String,
      companyId: map['companyId'] as CompanyID,
      role: (map['role'] as String).toCompanyUserRoles,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  }
