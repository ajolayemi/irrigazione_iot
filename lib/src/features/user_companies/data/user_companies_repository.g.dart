// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_companies_repository.dart';

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
    r'9f7d3db0e0e7b95eea3f2cec34283e0f6406c5c1';

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
    r'ef9a9d9f968ce36b7b223c966113216dcd1c4472';

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
String _$companyUserRoleHash() => r'799abbcb5922cf80c637c6b7e5567a2c4388caa1';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
