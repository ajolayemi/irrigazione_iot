import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/user_company.dart';

final kFakeUserCompanies = <UserCompany>[
  UserCompany(
    appUser: kFakeUsers[0],
    companyId: '1',
    role: CompanyUserRoles.admin,
  ),
  UserCompany(
    appUser: kFakeUsers[0],
    companyId: '2',
    role: CompanyUserRoles.user,
  ),
  UserCompany(
    appUser: kFakeUsers[2],
    companyId: '3',
    role: CompanyUserRoles.superuser,
  ),
  UserCompany(
    appUser: kFakeUsers[2],
    companyId: '4',
    role: CompanyUserRoles.admin,
  ),
  UserCompany(
    appUser: kFakeUsers[3],
    companyId: '5',
    role: CompanyUserRoles.user,
  ),
  UserCompany(
    appUser: kFakeUsers[3],
    companyId: '6',
    role: CompanyUserRoles.owner,
  ),
  UserCompany(
    appUser: kFakeUsers[5],
    companyId: '4',
    role: CompanyUserRoles.admin,
  ),
  UserCompany(
    appUser: kFakeUsers[5],
    companyId: '3',
    role: CompanyUserRoles.user,
  ),
  UserCompany(
    appUser: kFakeUsers[7],
    companyId: '2',
    role: CompanyUserRoles.user,
  ),
  UserCompany(
    appUser: kFakeUsers[7],
    companyId: '1',
    role: CompanyUserRoles.admin,
  ),
];
