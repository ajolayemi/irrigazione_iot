// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_users_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userCompaniesRepositoryHash() =>
    r'980a3613badb5264d65c0c1c0d95cbae30d46ac8';

/// See also [userCompaniesRepository].
@ProviderFor(userCompaniesRepository)
final userCompaniesRepositoryProvider =
    Provider<CompanyUsersRepository>.internal(
  userCompaniesRepository,
  name: r'userCompaniesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userCompaniesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserCompaniesRepositoryRef = ProviderRef<CompanyUsersRepository>;
String _$userCompaniesFutureHash() =>
    r'68fa5fd3fe2c09674cd71900425e2a4bb9ca1346';

/// See also [userCompaniesFuture].
@ProviderFor(userCompaniesFuture)
final userCompaniesFutureProvider =
    AutoDisposeFutureProvider<List<Company>>.internal(
  userCompaniesFuture,
  name: r'userCompaniesFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userCompaniesFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserCompaniesFutureRef = AutoDisposeFutureProviderRef<List<Company>>;
String _$userCompaniesStreamHash() =>
    r'b1c0abbc1db0e7fe825a03e5ccc1478100ccdd5f';

/// See also [userCompaniesStream].
@ProviderFor(userCompaniesStream)
final userCompaniesStreamProvider =
    AutoDisposeStreamProvider<List<Company>>.internal(
  userCompaniesStream,
  name: r'userCompaniesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userCompaniesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserCompaniesStreamRef = AutoDisposeStreamProviderRef<List<Company>>;
String _$companyUserRoleHash() => r'0bae44f8dd6375c20dbbd9d1c5d1111d3ac44c05';

/// See also [companyUserRole].
@ProviderFor(companyUserRole)
final companyUserRoleProvider = StreamProvider<CompanyUserRoles?>.internal(
  companyUserRole,
  name: r'companyUserRoleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyUserRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyUserRoleRef = StreamProviderRef<CompanyUserRoles?>;
String _$usersEmailAssociatedWithCompanyStreamHash() =>
    r'836a084d52a1ca3f154b004d9187da624d02130c';

/// See also [usersEmailAssociatedWithCompanyStream].
@ProviderFor(usersEmailAssociatedWithCompanyStream)
final usersEmailAssociatedWithCompanyStreamProvider =
    AutoDisposeStreamProvider<List<String?>>.internal(
  usersEmailAssociatedWithCompanyStream,
  name: r'usersEmailAssociatedWithCompanyStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usersEmailAssociatedWithCompanyStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersEmailAssociatedWithCompanyStreamRef
    = AutoDisposeStreamProviderRef<List<String?>>;
String _$usersAssociatedWithCompanyStreamHash() =>
    r'c45a2f165ff04cc1a198665711d743e1ae0178c9';

/// See also [usersAssociatedWithCompanyStream].
@ProviderFor(usersAssociatedWithCompanyStream)
final usersAssociatedWithCompanyStreamProvider =
    AutoDisposeStreamProvider<List<AppUser?>>.internal(
  usersAssociatedWithCompanyStream,
  name: r'usersAssociatedWithCompanyStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usersAssociatedWithCompanyStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersAssociatedWithCompanyStreamRef
    = AutoDisposeStreamProviderRef<List<AppUser?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
