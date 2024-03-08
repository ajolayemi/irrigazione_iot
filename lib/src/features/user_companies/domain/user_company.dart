// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';

import 'package:irrigazione_iot/src/features/authentication/model/app_user.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';

// A representation of the relationship between a user and a company
class UserCompany extends Equatable {
  const UserCompany({
    required this.appUser,
    required this.companyId,
    required this.role,
  });
  final AppUser appUser;
  final CompanyID companyId;
  final CompanyUserRoles role;

  @override
  List<Object> get props => [appUser, companyId];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appUser': appUser.toMap(),
      'companyId': companyId,
      'role': role.toString(),
    };
  }

  factory UserCompany.fromMap(Map<String, dynamic> map) {
    return UserCompany(
      appUser: AppUser.fromMap(map['appUser'] as Map<String, dynamic>),
      companyId: map['companyId'] as CompanyID,
      role: CompanyUserRoles.values.firstWhere(
        ((role) => role.toString() == map['role'] as String),
      ),
    );
  }

  @override
  bool get stringify => true;

  UserCompany copyWith({
    AppUser? appUser,
    CompanyID? companyId,
    CompanyUserRoles? role,
  }) {
    return UserCompany(
      appUser: appUser ?? this.appUser,
      companyId: companyId ?? this.companyId,
      role: role ?? this.role,
    );
  }
}
