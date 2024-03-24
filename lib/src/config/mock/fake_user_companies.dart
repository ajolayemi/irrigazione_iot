import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/user_companies/model/company_user.dart';

final kFakeUserCompanies = <CompanyUser>[
  CompanyUser(
    appUser: kFakeUsers[0],
    companyId: '1',
    role: CompanyUserRoles.admin,
  ),
  CompanyUser(
    appUser: kFakeUsers[0],
    companyId: '2',
    role: CompanyUserRoles.user,
  ),
  CompanyUser(
    appUser: kFakeUsers[2],
    companyId: '3',
    role: CompanyUserRoles.superuser,
  ),
  CompanyUser(
    appUser: kFakeUsers[2],
    companyId: '4',
    role: CompanyUserRoles.admin,
  ),
  CompanyUser(
    appUser: kFakeUsers[3],
    companyId: '5',
    role: CompanyUserRoles.user,
  ),
  CompanyUser(
    appUser: kFakeUsers[3],
    companyId: '6',
    role: CompanyUserRoles.owner,
  ),
  CompanyUser(
    appUser: kFakeUsers[5],
    companyId: '4',
    role: CompanyUserRoles.admin,
  ),
  CompanyUser(
    appUser: kFakeUsers[5],
    companyId: '3',
    role: CompanyUserRoles.user,
  ),
  CompanyUser(
    appUser: kFakeUsers[7],
    companyId: '2',
    role: CompanyUserRoles.user,
  ),
  CompanyUser(
    appUser: kFakeUsers[7],
    companyId: '1',
    role: CompanyUserRoles.admin,
  ),
];
