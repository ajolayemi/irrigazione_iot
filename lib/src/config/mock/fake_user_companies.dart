import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company_user.dart';

final kFakeUserCompanies = <CompanyUser>[
  CompanyUser(
    email: kFakeUsers[0].email,
    companyId: '1',
    role: CompanyUserRoles.admin,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    email: kFakeUsers[0].email,
    companyId: '2',
    role: CompanyUserRoles.user,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    email: kFakeUsers[2].email,
    companyId: '3',
    role: CompanyUserRoles.superuser,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    email: kFakeUsers[2].email,
    companyId: '4',
    role: CompanyUserRoles.admin,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    email: kFakeUsers[3].email,
    companyId: '5',
    role: CompanyUserRoles.user,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    email: kFakeUsers[3].email,
    companyId: '6',
    role: CompanyUserRoles.owner,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    email: kFakeUsers[5].email,
    companyId: '4',
    role: CompanyUserRoles.admin,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    email: kFakeUsers[5].email,
    companyId: '3',
    role: CompanyUserRoles.user,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    email: kFakeUsers[7].email,
    companyId: '2',
    role: CompanyUserRoles.user,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    email: kFakeUsers[7].email,
    companyId: '1',
    role: CompanyUserRoles.admin,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
