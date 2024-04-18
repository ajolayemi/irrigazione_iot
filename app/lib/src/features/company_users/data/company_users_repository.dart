import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/data/supabase_company_users_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/shared/providers/supabase_client_provider.dart';

part 'company_users_repository.g.dart';

// A repository to manage the companies connected to a user
// When either Supabase or Firebase is implemented, the repository that will be connected
// to this class will access the table where the users associated with the companies are stored
abstract class CompanyUsersRepository {
  /// Emits a list of [Company] linked with the provided user email
  Stream<List<Company>> watchCompaniesAssociatedWithUser(
      {required String email});

  /// Emits the [CompanyUserRoles] linked with the provided user email and company id
  Stream<CompanyUserRoles?> watchCompanyUserRole({
    required String email,
    required String companyId,
  });

  /// Fetches the [CompanyUserRoles] linked with the provided user email and company id
  Future<CompanyUserRoles?> fetchCompanyUserRole(
      {required String email, required String companyId});

  /// Fetches a list of user email addresses linked with the provided company id
  Future<List<CompanyUser?>> fetchUsersAssociatedWithCompany({
    required String companyId,
  });

  /// Emits a list of [CompanyUser]s linked with the provided company id if any
  Stream<List<CompanyUser?>> watchUsersAssociatedWithCompany({
    required String companyId,
  });

  /// Emits a [CompanyUser] linked with the provided user companyUserId
  Stream<CompanyUser?> watchCompanyUser({required String companyUserId});

  /// Fetches a [CompanyUser] linked with the provided user companyUserId
  Future<CompanyUser?> fetchCompanyUser({required String companyUserId});

  /// Emits a list of email addresses already associated with the provided company id
  Stream<List<String>> watchEmailsAssociatedWithCompany({
    required String companyId,
  });

  /// Adds a new [CompanyUser] to the database and returns the newly added [CompanyUser] if successful
  Future<CompanyUser?> addCompanyUser({required CompanyUser companyUser});

  /// Updates an existing [CompanyUser] in the database and returns the updated [CompanyUser] if successful
  Future<CompanyUser?> updateCompanyUser({required CompanyUser companyUser});

  /// Deletes a [CompanyUser] from the database and returns true if successful
  Future<bool> deleteCompanyUser({required String companyUserId});
}

@Riverpod(keepAlive: true)
CompanyUsersRepository companyUsersRepository(CompanyUsersRepositoryRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseCompanyUsersRepository(supabaseClient);
}



/// A stream that emits a list of companies associated with the current user
@riverpod
Stream<List<Company>> userCompaniesStream(UserCompaniesStreamRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final user = authRepository.currentUser;
  if (user == null) {
    return Stream.value([]);
  }
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);
  return userCompaniesRepository.watchCompaniesAssociatedWithUser(
    email: user.email,
  );
}

@Riverpod(keepAlive: true)
Stream<CompanyUserRoles?> companyUserRole(CompanyUserRoleRef ref) {
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);
  final currentSelectedCompany = ref.watch(currentTappedCompanyProvider).value;
  final authRepository = ref.watch(authRepositoryProvider);
  final user = authRepository.currentUser;
  if (user == null || currentSelectedCompany == null) {
    return const Stream.empty();
  }
  return userCompaniesRepository.watchCompanyUserRole(
    email: user.email,
    companyId: currentSelectedCompany.id,
  );
}

@riverpod
Stream<List<CompanyUser?>> usersAssociatedWithCompanyStream(
    UsersAssociatedWithCompanyStreamRef ref) {
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);
  final currentSelectedCompany = ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompany == null) {
    return Stream.value([]);
  }
  return userCompaniesRepository.watchUsersAssociatedWithCompany(
    companyId: currentSelectedCompany.id,
  );
}

@riverpod
Stream<CompanyUser?> companyUserStream(CompanyUserStreamRef ref,
    {required String companyUserId}) {
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);

  return userCompaniesRepository.watchCompanyUser(companyUserId: companyUserId);
}

@riverpod
Stream<List<String>> emailsAssociatedWithCompanyStream(
    EmailsAssociatedWithCompanyStreamRef ref) {
  final userCompaniesRepository = ref.watch(companyUsersRepositoryProvider);
  final currentSelectedCompany = ref.watch(currentTappedCompanyProvider).value;
  if (currentSelectedCompany == null) {
    return Stream.value([]);
  }
  return userCompaniesRepository.watchEmailsAssociatedWithCompany(
    companyId: currentSelectedCompany.id,
  );
}
