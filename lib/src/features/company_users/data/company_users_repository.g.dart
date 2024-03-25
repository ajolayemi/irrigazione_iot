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
String _$usersAssociatedWithCompanyStreamHash() =>
    r'28904928a2f1afc5149931cf4b94a23d15e0f3cd';

/// See also [usersAssociatedWithCompanyStream].
@ProviderFor(usersAssociatedWithCompanyStream)
final usersAssociatedWithCompanyStreamProvider =
    AutoDisposeStreamProvider<List<CompanyUser?>>.internal(
  usersAssociatedWithCompanyStream,
  name: r'usersAssociatedWithCompanyStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usersAssociatedWithCompanyStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersAssociatedWithCompanyStreamRef
    = AutoDisposeStreamProviderRef<List<CompanyUser?>>;
String _$companyUserStreamHash() => r'd76223343d205a5771e37d47cde7cfacf60efd65';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [companyUserStream].
@ProviderFor(companyUserStream)
const companyUserStreamProvider = CompanyUserStreamFamily();

/// See also [companyUserStream].
class CompanyUserStreamFamily extends Family<AsyncValue<CompanyUser?>> {
  /// See also [companyUserStream].
  const CompanyUserStreamFamily();

  /// See also [companyUserStream].
  CompanyUserStreamProvider call({
    required String companyUserId,
  }) {
    return CompanyUserStreamProvider(
      companyUserId: companyUserId,
    );
  }

  @override
  CompanyUserStreamProvider getProviderOverride(
    covariant CompanyUserStreamProvider provider,
  ) {
    return call(
      companyUserId: provider.companyUserId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'companyUserStreamProvider';
}

/// See also [companyUserStream].
class CompanyUserStreamProvider
    extends AutoDisposeStreamProvider<CompanyUser?> {
  /// See also [companyUserStream].
  CompanyUserStreamProvider({
    required String companyUserId,
  }) : this._internal(
          (ref) => companyUserStream(
            ref as CompanyUserStreamRef,
            companyUserId: companyUserId,
          ),
          from: companyUserStreamProvider,
          name: r'companyUserStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$companyUserStreamHash,
          dependencies: CompanyUserStreamFamily._dependencies,
          allTransitiveDependencies:
              CompanyUserStreamFamily._allTransitiveDependencies,
          companyUserId: companyUserId,
        );

  CompanyUserStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyUserId,
  }) : super.internal();

  final String companyUserId;

  @override
  Override overrideWith(
    Stream<CompanyUser?> Function(CompanyUserStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CompanyUserStreamProvider._internal(
        (ref) => create(ref as CompanyUserStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyUserId: companyUserId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<CompanyUser?> createElement() {
    return _CompanyUserStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyUserStreamProvider &&
        other.companyUserId == companyUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CompanyUserStreamRef on AutoDisposeStreamProviderRef<CompanyUser?> {
  /// The parameter `companyUserId` of this provider.
  String get companyUserId;
}

class _CompanyUserStreamProviderElement
    extends AutoDisposeStreamProviderElement<CompanyUser?>
    with CompanyUserStreamRef {
  _CompanyUserStreamProviderElement(super.provider);

  @override
  String get companyUserId =>
      (origin as CompanyUserStreamProvider).companyUserId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
