import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/data/supabase_role_management_repository.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/models/superuser.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'role_management_repository.g.dart';

abstract class RoleManagementRepository {
  /// Emits true if the user is an admin of the company with the given [companyId]
  Stream<bool> isUserAdmin(String email, String companyId);

  /// Emits true if the user with the given [email] is a superuser
  Stream<bool> isUserSuperuser(String email);

  /// Emits true if the user with the given [email] is the owner of the company with the given [companyId]
  Stream<bool> isUserOwner(String email, String companyId);

  /// Emits true if the user with the given [email] is a basic user of the company with the given [companyId]
  /// A basic user is a user that is not an admin, owner or superuser
  Stream<bool> isBasicUser(String email, String companyId);

  /// Emits the [SuperUser] for the given [email]
  Stream<SuperUser?> watchSuperuser(String email);

  Stream<CompanyUserRole?> watchUserCompanyRole(String email, String companyId);
}

@Riverpod(keepAlive: true)
RoleManagementRepository roleManagementRepository(
    RoleManagementRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseRoleManagementRepository(supabaseClient);
}

@riverpod
Stream<bool> userIsAdminStream(UserIsAdminStreamRef ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final email = authRepo.currentSession?.user.email;
  if (email == null) return Stream.value(false);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Stream.value(false);
  final roleRepo = ref.watch(roleManagementRepositoryProvider);
  return roleRepo.isUserAdmin(email, currentSelectedCompanyByUser.id);
}

@riverpod
Stream<bool> userIsSuperuserStream(UserIsSuperuserStreamRef ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final email = authRepo.currentSession?.user.email;
  if (email == null) return Stream.value(false);
  final roleRepo = ref.watch(roleManagementRepositoryProvider);
  return roleRepo.isUserSuperuser(email);
}

@riverpod
Stream<bool> userIsOwnerStream(UserIsOwnerStreamRef ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final email = authRepo.currentSession?.user.email;
  if (email == null) return Stream.value(false);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Stream.value(false);
  final roleRepo = ref.watch(roleManagementRepositoryProvider);
  return roleRepo.isUserOwner(email, currentSelectedCompanyByUser.id);
}

@riverpod
Stream<bool> userIsBasicStream(UserIsBasicStreamRef ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final email = authRepo.currentSession?.user.email;
  if (email == null) return Stream.value(false);
  final currentSelectedCompanyByUser =
      ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompanyByUser == null) return Stream.value(false);
  final roleRepo = ref.watch(roleManagementRepositoryProvider);
  return roleRepo.isBasicUser(email, currentSelectedCompanyByUser.id);
}

/// As at now, only superusers are allowed to create items
@riverpod
Stream<bool> userCanCreateStream(UserCanCreateStreamRef ref) {
  final isSuperUser = ref.watch(userIsSuperuserStreamProvider).valueOrNull;
  return Stream.value(isSuperUser ?? false);
}

/// As at now, only superusers are allowed to update
@riverpod
Stream<bool> userCanEditStream(UserCanEditStreamRef ref) {
  final isSuperUser = ref.watch(userIsSuperuserStreamProvider).valueOrNull;
  return Stream.value(isSuperUser ?? false);
}

/// As at now, only superusers are allowed to delete items
@riverpod
Stream<bool> userCanDeleteStream(UserCanDeleteStreamRef ref) {
  final isSuperUser = ref.watch(userIsSuperuserStreamProvider).valueOrNull;
  return Stream.value(isSuperUser ?? false);
}
