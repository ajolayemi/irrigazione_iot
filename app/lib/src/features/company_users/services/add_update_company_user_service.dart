import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/models/company_user.dart';

part 'add_update_company_user_service.g.dart';

class AddUpdateCompanyUserService {
  const AddUpdateCompanyUserService(this._ref);
  final Ref _ref;

  Future<void> addCompanyUser(CompanyUser companyUser) async {
    // the companyUser argument that is provided as argument has no company
    // id, so we need to get it from somewhere else

    final user = _ref.read(authRepositoryProvider).currentUser;

    // If user is null, that shouldn't be the case but just to be sure
    if (user == null) {
      debugPrint('Exiting addCompanyUser, user is null');
      return;
    }

    final selectedCompanyRepo = _ref.read(selectedCompanyRepositoryProvider);
    final companyId = selectedCompanyRepo.loadSelectedCompanyId(user.uid);

    // Just in case no company id is found
    if (companyId == null) {
      debugPrint('Exiting addCompanyUser, companyId is null');
      return;
    }

    // Reaching here means all necessary checks have been passed
    await _ref.read(companyUsersRepositoryProvider).addCompanyUser(
          companyUser: companyUser.copyWith(
            companyId: companyId,
          ),
        );
  }

  Future<void> updateCompanyUser(CompanyUser companyUser) async {
    // The only check to perform here is to make sure that who reaches
    // this point has a valid companyUser object

    final user = _ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      debugPrint('Exiting updateCompanyUser, user is null');
      return;
    }

    // Reaching here means all necessary checks have been passed
    await _ref.read(companyUsersRepositoryProvider).updateCompanyUser(
          companyUser: companyUser,
        );
  }
}

@riverpod
AddUpdateCompanyUserService addUpdateCompanyUserService(
    AddUpdateCompanyUserServiceRef ref) {
  return AddUpdateCompanyUserService(ref);
}
