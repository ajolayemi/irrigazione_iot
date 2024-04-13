import '../enums/roles.dart';
import 'fake_users_list.dart';
import '../../features/authentication/model/app_user.dart';
import '../../features/company_users/model/company_user.dart';

final kFakeCompanyUsers = <CompanyUser>[
  CompanyUser(
    id: '1',
    email: kFakeUsers[0].email,
    fullName: kFakeUsers[0].fullName,
    companyId: '1',
    role: CompanyUserRoles.admin,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    id: '2',
    email: kFakeUsers[0].email,
    fullName: kFakeUsers[0].fullName,
    companyId: '2',
    role: CompanyUserRoles.user,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    id: '3',
    email: kFakeUsers[2].email,
    fullName: kFakeUsers[2].fullName,
    companyId: '3',
    role: CompanyUserRoles.superuser,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    id: '4',
    email: kFakeUsers[2].email,
    fullName: kFakeUsers[2].fullName,
    companyId: '4',
    role: CompanyUserRoles.admin,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    id: '5',
    email: kFakeUsers[3].email,
    fullName: kFakeUsers[3].fullName,
    companyId: '5',
    role: CompanyUserRoles.user,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    id: '6',
    email: kFakeUsers[3].email,
    fullName: kFakeUsers[3].fullName,
    companyId: '6',
    role: CompanyUserRoles.owner,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    id: '7',
    email: kFakeUsers[5].email,
    fullName: kFakeUsers[5].fullName,
    companyId: '4',
    role: CompanyUserRoles.admin,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    id: '8',
    email: kFakeUsers[5].email,
    fullName: kFakeUsers[5].fullName,
    companyId: '3',
    role: CompanyUserRoles.user,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    id: '9',
    email: kFakeUsers[7].email,
    fullName: kFakeUsers[7].fullName,
    companyId: '2',
    role: CompanyUserRoles.user,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CompanyUser(
    id: '10',
    email: kFakeUsers[7].email,
    fullName: kFakeUsers[7].fullName,
    companyId: '1',
    role: CompanyUserRoles.admin,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
