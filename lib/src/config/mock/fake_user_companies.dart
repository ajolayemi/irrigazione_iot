import 'package:irrigazione_iot/src/config/mock/fake_users_list.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/user_company.dart';

final kFakeUserCompanies = <UserCompany>[
  UserCompany(
    appUser: kFakeUsers[0],
    companyId: '1',
  ),
  UserCompany(
    appUser: kFakeUsers[0],
    companyId: '2',
  ),
  UserCompany(
    appUser: kFakeUsers[2],
    companyId: '3',
  ),
  UserCompany(
    appUser: kFakeUsers[2],
    companyId: '4',
  ),
  UserCompany(
    appUser: kFakeUsers[3],
    companyId: '5',
  ),
  UserCompany(
    appUser: kFakeUsers[3],
    companyId: '6',
  ),
  UserCompany(
    appUser: kFakeUsers[5],
    companyId: '4',
  ),
  UserCompany(
    appUser: kFakeUsers[5],
    companyId: '3',
  ),
  UserCompany(
    appUser: kFakeUsers[7],
    companyId: '2',
  ),
  UserCompany(
    appUser: kFakeUsers[7],
    companyId: '1',
  ),
];
